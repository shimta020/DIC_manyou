class LabelsController < ApplicationController
  before_action :admin_user
  before_action :set_label, only: [:destroy]
  def index
    @labels = Label.all
  end
  def new
    @label = Label.new
  end
  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to labels_path, notice: '新規ラベルを作成しました'
    else
      render :new
    end
  end
  def destroy
    if @label.destroy
      redirect_to labels_path, notice: 'ラベルを削除しました'
    end
  end
  private
  def label_params
    params.require(:label).permit(:label_name)
  end
  def set_label
    @label = Label.find(params[:id])
  end
  def admin_user
    redirect_to root_url, notice: '管理者以外はアクセス出来ません!!!' unless current_user.admin?
  end
end
