class GptParser
  include HTTParty

  def initialize
    @options = { "x-api-key": API_KEY, "customer-id": CUSTOMER_ID, "Content-Type": "application/json"  }  # replace with your key and github id
  end

  def request(args = {})
    response = self.class.post("https://experimental.willow.vectara.io/v1/chat/completions",
      headers: @options,
      body: {
        model: 'gpt-3.5-turbo',
        temperature: 0,
        messages: [
          {
            role: "system",
            content: "
                      * You are a webservice that searches through a given piece of text and identifies relevant information based on a provided JSON schema. 
                      * The goal is to collect and return all relevant pieces of text while ensuring they conform to the schema. 
                      * If an error occurs, return the following json: {'success': false, 'error_message': 'message', 'value': {}}
                      * Errors must only occur if there is a syntax error
                      * You must not return an error and use best effort to assign values from the text to the json output.
                      * The overall returned json MUST be valid, and must be parsable.

                      -----------------

                      Text: 

                      #{args.fetch(:text)}


                      Replace any double quotes inside values of the json with single quotes
                      give the response as json, no special charecters, no new lines, use the following schema for the response, 

                      Json Schema:
                        
                      #{args.fetch(:json_schema)}
                      ",
          }
        ]
      }.to_json)


      response
      # return json
  end
end
