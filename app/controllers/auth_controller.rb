class AuthController < ApplicationController

  # GET
  def callback

    provider_user = request.env['omniauth.auth']
    # render json: {params: params, provider_user: provider_user}

    if params[:provider] == "github"

      user = User.find_or_initialize_by(provider_id: provider_user['uid'], provider: params[:provider])

      user.provider_hash = provider_user['credentials']['token']
      user.name = provider_user['info']['name']
      user.email = provider_user['info']['email']
      user.image_url = provider_user['info']['image']
      user.save

    elsif params[:provider] == "stackexchange"

      user = User.find_or_initialize_by(provider_id: provider_user['uid'], provider: params[:provider])

      user.provider_hash = provider_user['credentials']['token']
      user.name = provider_user['info']['nickname']
      # StackExchange does not send user email in their api
      user.email = ''
      user.image_url = provider_user['info']['image']
      user.save

    elsif params[:provider] == "gitlab"

      user = User.find_or_initialize_by(provider_id: provider_user['uid'], provider: params[:provider])

      user.provider_hash = provider_user['credentials']['token']
      user.name = provider_user['info']['name']
      user.email = provider_user['info']['email']
      user.image_url = provider_user['extra']['raw_info']['avatar_url']
      user.save

    end

    # Create user session
    session[:user_id] = user.id

    # Send user to home page
    redirect_to root_path

  end

  # auth_logout GET
  # def logout
  #   session[:user_id] = nil
  #   redirect_to root_path
  # end

  # auth_failure GET
  def failure
    failure = {failure: "Uh oh! Looks like something didn't go quite right."}
    render json: failure
  end


end
