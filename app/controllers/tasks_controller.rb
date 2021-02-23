class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.order(created_at: :desc)
    if params[:status].present? && params[:status].present?
      @tasks = Task.search_title(params[:search]).search_status(params[:status])
    elsif params[:search].present?
      @tasks = Task.search_title(params[:search])
    elsif params[:status].present?
      @tasks = Task.search_status(params[:status])
    end
    if params[:sort_expired]
      @tasks = Task.dead_limit
    end
  end
  def new
    @task = Task.new
  end
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: '作成完了！'
    else
      render :new
    end
  end
  def show
  end
  def edit
  end
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: '編集完了!'
    else
      render :edit
    end
  end
  def destroy
    @task.destroy
      redirect_to tasks_path, notice: '削除しました'
  end
  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
