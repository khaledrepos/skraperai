class ResourcesController < ApplicationController

  def index
    @project = Project.find(params[:project_id])

  end

  def new
  end


    # POST /projects or /projects.json
    def create_bulk
      @project = Project.new(project_params)

      @target_urls = params[:target_urls].split("\n")

      browser = Watir::Browser.new
      
      
      @target_urls.each do |url|

        browser.goto url
    
        # get content
        content = browser.html

        # preprocessing
        processed_content = HtmlCleaner.run(content)
        
        # processed by gpt
        gpt_response = GptParser.new.request(json_schema: params[:json_schema], text: processed_content)
        gpt_response = gpt_response.body
        
        
        PlaygroundRequest.create(target_url: params[:target_url], json_schema: params[:json_schema], response: content, response_clean: processed_content, response_gpt: gpt_response )
        
      end


      browser.close if browser
  
      respond_to do |format|
        if @project.save
          format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
          format.json { render :show, status: :created, location: @project }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
    end



  def ask
  end



end