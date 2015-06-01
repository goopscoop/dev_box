class SessionsController < ApplicationController

  # login GET
  def new
  end

  # login POST
  def create
  end

  # check GET
  def check

    render json: {user: @current_user || false}

  end

  # logout DELETE
  def destroy

    session[:user_id] = nil
    render json: {result: true}

  end

end
