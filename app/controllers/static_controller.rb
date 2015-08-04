class StaticController < ApplicationController

  def index
    popular_tools = []
    popular_votes = Tvote.find_by_sql("SELECT tool_id, sum(vote)
                                FROM tvotes
                                Group by tool_id
                                Order by sum(vote) desc
                                LIMIT 5")
    popular_votes.each do |vote|
      popular_tools.push(Tool.find_by_id(vote.tool_id))
    end
    popular_tools = add_tool_info popular_tools

    tools = Tool.limit(5).order('id desc')
    recent_tools = add_tool_info tools

    render json: { popular: popular_tools , recent: recent_tools }
  end


end
