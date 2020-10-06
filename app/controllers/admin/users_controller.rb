class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show
    @tasks = Task.where(user_id: @user.id)
  end

  def edit
  end

  def update
    puts @user
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      flash[:notice] = '編集できませんでした。'
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: '削除しました'
    else
      redirect_to admin_users_path, notice: '削除失敗しました。'
    end
  end

  private
  def if_not_admin
    unless current_user.admin?#管理ユーザー以外で特定のアクションを実行しようとした場合には、トップページにリダイレクトさせる、
      flash[:notice] = '管理者以外アクセスできません。'
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
