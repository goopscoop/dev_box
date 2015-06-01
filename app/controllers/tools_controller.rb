class ToolsController < ApplicationController

  # tools GET
  def index
    all_tools = Tool.all
    tool_info = {}

    all_tools.each do |tool|

      cats = []
      tool.categories.each do |cat|
        cats.push({ id:cat.id , category:cat.category })
      end

      tags = []
      tool.tags.each do |tag|
        tags.push({ id:tag.id , tag:tag.tag})
      end

      tool_info[tool.title] = { title: tool.title, tags: tags, categories: cats }
    end
    render json: tool_info
  end

  # tool GET
  def show
  end

  # new_tool GET
  def new
  end

  # POST
  def create
  end

  # edit_tool GET
  def edit
  end

  # PATCH or PUT
  def update
  end

  # DELETE
  def destroy
  end


end
