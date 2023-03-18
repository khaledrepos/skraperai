class GptSqlGenerator
  include HTTParty
  
  def initialize
    @options = { "x-api-key": API_KEY, "customer-id": CUSTOMER_ID, "Content-Type": "application/json"  } 
  end

  def request(args = {})
    response = self.class.post("https://experimental.willow.vectara.io/v1/chat/completions",
      headers: @options,
      body: {
        model: 'gpt-3.5-turbo',
        temperature: 0,
        messages: [
          {
            role: "user",
            content: args.fetch(:user_command)
          },
          {
            role: "system",
            content: "
                    You are an SQL generator. 
                    Take the user's question from the previous prompt, and generate a postgres SQL query for table whose schema is defined below.

                      -----------------

                      Table Schema: 

                      CREATE TABLE resources (
                        id SERIAL PRIMARY KEY,
                        target_url VARCHAR(255),
                        response VARCHAR(255),
                        payload JSON,
                        created_at TIMESTAMP NOT NULL,
                        updated_at TIMESTAMP NOT NULL
                      );
                      
                      CREATE INDEX index_resources_on_project_id ON resources (project_id);
                      

                      Json Schema for 'payload' column:

                      #{args.fetch(:json_schema)}



                      give the response as json, no special charecters, no new lines.
                      the json must have two keys: 'success' and 'content'
                      "
          }

        ]
      }.to_json)


      response
      # return json
  end
end
