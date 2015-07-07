class ValidateController < ApplicationController

  def index
    tool_title = params[:title]

    tools = Tool.where('title ilike ?', "%#{tool_title}%")

    if tools.length == 1
      render json: { uniqueness: false, title: tools.title, id: tools.id, message: "We found a tool with a similar name in our database." }
    elsif tools.length > 1
      render json: { uniqueness: false, tools: tools, message: "We found #{tools.length} tools with a similar name in our database." }
    else
      render json: { uniqueness: true }
    end

  end

end