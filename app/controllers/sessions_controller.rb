class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :create 

  def create
    user = User.find_or_create_auth_hash!(request.env["omniauth.auth"])
    session[:user_id] = user.id
    logger.info "------------------"
    logger.info "#{session}"
    logger.info "#{current_user}"
    logger.info "------------------"
    redirect_to root_path, notice: "You logged in"
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "You logged out"
  end
end