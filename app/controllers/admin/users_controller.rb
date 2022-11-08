class Admin::UsersController < ApplicationController
  before_action :set_user, only: %I[show edit update destroy]
  skip_before_action :login_required, only: %I[index new create show edit update destroy]
  skip_before_action :already_logged_in, only: %I[index new create show edit update destroy]
  skip_before_action :no_access_to_others, only: %I[index new create show edit update destroy]
  skip_before_action :if_not_admin, only: %I[index new create show edit update destroy]


  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザー　#{@user.name}を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー　#{@user.name}を更新しました"
    else
      render :new
    end
  end

  def show
  end

  def destroy
    @user.tasks.destroy
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザー　#{@user.name}とタスクを削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end