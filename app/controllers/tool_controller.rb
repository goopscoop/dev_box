class ToolController < ApplicationController

  def create
    if current_user
      # params[:user_id] is actually the tool id. THIS IS NOT A BUG, ITS A FEATURE
      tool = Tool.find_by_id(params[:user_id])
      current_user.tools << tool
      render json: {result:true}
    else
      render json: {result:false}
    end
  end

  def destroy
    if current_user
      current_user.tools.delete(Tool.find(params[:id]))
      render json: {result:true}
    else
      render json: {result:false}
    end
  end

end
