class ApplicationController < ActionController::Base
  helper_method :current_user
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required
  # before_action :basic_auth

  # private

  # def basic_auth
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == 'ishii' && password == '555'
  #   end
  # end


  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to new_session_path unless current_user
  end
end