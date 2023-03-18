class PlaygroundsController < ApplicationController


  def show
    @playground_request = PlaygroundRequest.find_by(id: params[:request_id]) || PlaygroundRequest.new

    @clean_output_json = 
      if @playground_request.response_gpt.present?
        json = JSON.parse(@playground_request.response_gpt)
        
        clean = json['choices'][0].dig('message','content').gsub("\\n", "\n").gsub("\n","").gsub(/\s{2,}/, "\s")
        
        begin
          JSON.parse(clean)
        rescue 
          clean
        end
      else
        '{}'
      end


    render 'playgrounds/show'
  end

  def simulate

    playground_request = PlaygroundRequest.new(target_url: params[:target_url], json_schema: params[:json_schema])
    browser = nil

    begin
      browser = Watir::Browser.new


      browser.goto params[:target_url]

      content = browser.html
      playground_request.response = content
      browser.close if browser

      # preprocessing
      processed_content = HtmlCleaner.run(content)
      playground_request.response_clean = processed_content
  
      # processed by gpt
      gpt_response = GptParser.new.request(json_schema: params[:json_schema], text: processed_content)
      gpt_response = gpt_response.body    
      playground_request.response_gpt = gpt_response
      
    rescue Exception => e
      flash[:notice] = "Error: #{e}"
    ensure
      browser.close if browser
      playground_request.save!
      redirect_to playground_path(request_id: playground_request.id)
    end

  end

  def create_project
  end
end