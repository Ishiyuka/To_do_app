class UsersController < ApplicationController
  before_action :set_user, only: %I[show edit update]
  skip_before_action :login_required, only: %I[new create]
  skip_before_action :already_logged_in, only: %I[show]
  skip_before_action :no_access_to_others, only: %I[new create]
  skip_before_action :if_not_admin, only: %I[new create show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @tasks = @user.tasks
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end