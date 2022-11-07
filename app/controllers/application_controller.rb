class ApplicationController < ActionController::Base
  helper_method :current_user
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required
  before_action :already_logged_in
  before_action :no_access_to_others
  before_action :if_not_admin
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

  def already_logged_in
    if logged_in?
      flash[:notice] = "ログインしています"
      redirect_to tasks_path
    end
  end

  def no_access_to_others
    if @current_user.id != params[:id].to_i
      flash[:notice] = "アクセスできません"
      redirect_to tasks_path
    end
  end

  def  if_not_admin
    redirect_to tasks_path unless current_user.admin?
    flash[:notice] = "管理権限がありません"
  end
end