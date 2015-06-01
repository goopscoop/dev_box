class ToolsController < ApplicationController

  def add_tool_info tool
        cats = []
        tool.categories.each do |cat|
          cats.push({ id: cat[:id] , category: cat[:category] })
        end
        tags = []
        tool.tags.each do |tag|
          tags.push({ id: tag[:id] , tag: tag[:tag]})
        end
        return({ id: tool.id, title: tool.title, tags: tags, categories: cats })
  end

  # tools GET
  def index

    tool_info = []
    search_term = params[:q]

    if search_term
      searchMatch = Tool.where('title ilike ?', "%#{search_term}%")
      tagMatch = Tag.where('tag ilike ?', "%#{search_term}%")

      # Add tools to json + associated tags and categories
      searchMatch.each do |tool|
        tool_info.push(add_tool_info tool)
      end

      # Add tags to seach results then add associated tools and categories
      tagMatch.each do |tag|

        tag.tools.each do |tool|
          # Searches for an instance of this tool in current results, returns object if there, else returns nil
          # if nil, end loop
          if tool_info.any? {|t| t[:id] == tool[:id]}
            return
          else
            tool_info.push(add_tool_info tool)
          end
        end

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

        tool_info.push({ id: tool.id, title: tool.title, tags: tags, categories: cats })
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
