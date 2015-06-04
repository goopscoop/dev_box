class UsersController < ApplicationController
# class UsersController < ApiController

  def add_tool_info tool
        cats = []
        tool.categories.each do |cat|
          cats.push({ id: cat[:id] , category: cat[:category] })
        end
        tags = []
        tool.tags.each do |tag|
          tags.push({ id: tag[:id] , tag: tag[:tag]})
        end

        return({ id: tool.id, title: tool.title, web_url: tool.web_url, repo_url: tool.repo_url, doc_url: tool.doc_url, language: tool.language, tags: tags, categories: cats })
  end


  # users GET
  def index
    @user = User.all
    render json: @user
  end

  # user GET
  def show
    categories = Category.all
    tags = Tag.all
    tools = current_user.tools
    tool_info = []
    tools.each do |tool|
      tool_info.push(add_tool_info tool)
    end

    render json: { tools: tool_info, categories: categories, tags: tags }
  end

  # new_user GET
  def new
  end

  # POST
  def create
  end

  # edit_user GET
  def edit
  end

  # PATCH or PUT
  def update
  end

  # DELETE
  def destroy
  end

end
