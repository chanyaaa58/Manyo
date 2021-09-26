class UsersController < ApplicationController
  before_action :check_user_login, only: [:new]
  before_action :user_check, only: [:show]
  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'ログインしました'
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def check_user_login
    if logged_in?
      redirect_to tasks_path, notice:"ログイン中です。まずログアウトしてください。"
    end
  end

  def user_check
    user = User.find(params[:id])
    if current_user.id != user.id
      redirect_to tasks_path, notice: "権限がありません"
    end
  end
end
