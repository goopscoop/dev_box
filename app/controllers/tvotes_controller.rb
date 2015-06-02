class TvotesController < ApplicationController

  # tool_tvotes POST
  def create
    tool = Tool.find_by_id(params[:tool_id])
    tv = Tvote.create(vote:1)
    current_user.tvotes << tv
    tool.tvotes << tv
    votes = 0
    tool.tvotes.each do |vote|
      votes += vote.vote
    end
    render json: { votes:votes }
  end

  # tool_tvote DELETE
  def destroy
  end

end
