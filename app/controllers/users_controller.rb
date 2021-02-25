class UsersController < ApplicationController
  before_action :authenticate_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  def new
    if current_user != nil
      redirect_to user_path(current_user.id)
    else
      @user = User.new
    end
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
    if current_user.id != @user.id
      redirect_to tasks_path
    end
  end
  def edit
  end
  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  def set_user
    @user = User.find(params[:id])
  end
end
