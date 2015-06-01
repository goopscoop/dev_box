class ToolsController < ApplicationController

  # tools GET
  def index

    tool_info = []
    search_term = params[:q]

    if search_term
      searchMatch = Tool.where('title ilike ?', "%#{search_term}%")
      searchMatch.each do |tool|
        cats = []
        tool.categories.each do |cat|
          cats.push({ id: cat[:id] , category: cat[:category] })
        end
        tags = []
        tool.tags.each do |tag|
          tags.push({ id: tag[:id] , tag: tag[:tag]})
        end
        tool_info.push({title: tool.title, tags: tags, categories: cats})
      end

        render json: tool_info

    else

      all_tools = Tool.all

      all_tools.each do |tool|

        cats = []
        tool.categories.each do |cat|
          cats.push({ id: cat[:id] , category: cat[:category] })
        end

        tags = []
        tool.tags.each do |tag|
          tags.push({ id: tag[:id] , tag: tag[:tag]})
        end

        tool_info.push({ title: tool.title, tags: tags, categories: cats })
      end

      render json: tool_info

    end
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
