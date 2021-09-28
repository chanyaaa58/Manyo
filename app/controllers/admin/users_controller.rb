class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :show]
  before_action :checking_admin

  def index
    @users = User.select(:id, :name, :email, :admin).order("created_at").page(params[:page]).per(10)
  end

  def show
    @tasks = @user.tasks.all
    @tasks = @tasks.page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path(@user.id), notice: "ユーザー登録しました"
    else
      render :new, notice: "ユーザー登録ができませんでした"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path(@user.id), notice: "ユーザー情報を更新しました"
    else
      render :edit, notice: "ユーザー情報の更新に失敗しました"
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "#{@user.name}さんのアカウントを削除しました"
    else
      redirect_to admin_users_path, notice: "管理者は最低１人必要の為、#{@user.name}さんのアカウントを削除できません"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def checking_admin
    if current_user.nil? || !current_user.admin?
      redirect_to tasks_path, notice: "管理者以外はアクセスできません。"
    end
  end
end
