class ApplicationController < ActionController::Base
  protect_from_forgery # CSRF 対策

  before_action :authenticate
  helper_method :logged_in?, :current_user # コントローラーにあるメソッドをヘルパーのようにビューで使いたい。 html.hamlの中でも使いたい。

  private

  def logged_in?
    !!current_user
  end

  def current_user
    reset_session
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def authenticate
    return if logged_in?
    redirect_to root_path, alert: "Please login"
  end
end
