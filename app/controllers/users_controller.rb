class UsersController < ApplicationController

  # users GET
  def index
    @user = User.all
    render json: @user
  end

  # user GET
  def show
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
