class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.all.order(created_at: :asc)
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'ユーザーが1人増えました〜'
    else
      render :new
    end
  end
  def show
  end
  def edit
  end
  def update
    if @user.update(user_params) && current_page?(edit_admin_user_path(@user.id))
      redirect_to admin_users_path, notice: '#{@user.name}さんのプロフィールを編集しました'
    else
      render :edit
    end
  end
  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: 'ユーザーを削除しました'
    else
      redirect_to admin_users_path, notice: '削除に失敗しました...'
    end
  end
  private
  def admin_user
    redirect_to root_path unless current_user.admin?
    flash[:alert] = '管理者以外はアクセスできません！'
  end
  def user_params
    params.require(:user).permit(:name,
                                 :email, 
                                 :password, 
                                 :password_confirmation,
                                 :admin)
  end
  def set_user
    @user = User.find(params[:id])
  end
end
