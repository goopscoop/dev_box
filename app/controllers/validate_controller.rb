class ValidateController < ApplicationController

  def index
    tools = db_find_by_tool_title params[:title]
    if tools.length > 0
      render json: { uniqueness: false, tools: tools, message: "We found #{tools.length} tool(s) with a similar name in our database." }
    else
      render json: { uniqueness: true }
    end
  end


end