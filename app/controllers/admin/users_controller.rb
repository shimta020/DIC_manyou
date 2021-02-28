class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.all.includes(:tasks).order(created_at: :asc).page(params[:page]).per(10)
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
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id), notice: "#{@user.name}さんのプロフィールを編集しました"
    else
      flash[:notice] = '管理者は最低1人必要です'
      render :edit
    end
  end
  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: 'ユーザーを削除しました'
    else
      flash[:notice] = '管理者は最低1人必要です'
      redirect_to admin_users_path
    end
  end
  private
  def admin_user
    redirect_to root_url, notice: '管理者以外はアクセス出来ません!!!' unless current_user.admin?
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
