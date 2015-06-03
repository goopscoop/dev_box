class UsersController < ApplicationController
# class UsersController < ApiController

  # users GET
  def index
    @user = User.all
    render json: @user
  end

  # user GET
  def show
    tools = current_user.tools
    render json: { tools: tools }
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
