class ToolController < ApplicationController

  def create
    if current_user
      tool = Tool.find_by_id(params[:user_id])
      current_user.tools << tool
      render json: {result:true}
    else
      render json: {result:false}
    end
  end
end
