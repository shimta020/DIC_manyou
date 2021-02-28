class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  def index
    @tasks = current_user.tasks.order(created_at: :desc)
    if params[:search].present? && params[:status].present?
      @tasks = current_user.tasks.search_title(params[:search]).search_status(params[:status]).page(params[:page]).per(10)
    elsif params[:search].present?
      @tasks = current_user.tasks.search_title(params[:search]).page(params[:page]).per(10)
    elsif params[:status].present?
      @tasks = current_user.tasks.search_status(params[:status]).page(params[:page]).per(10)
    elsif params[:label_id].present?
      @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] }).page(params[:page]).per(10)
    end

    if params[:sort_expired]
      @tasks = current_user.tasks.sort_deadline.page(params[:page]).per(10)
    end

    if params[:sort_priority]
      @tasks = current_user.tasks.sort_priority.page(params[:page]).per(10)
    end
    
    @tasks = @tasks.page(params[:page]).per(10)
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:title,
                                 :content,
                                 :deadline, 
                                 :status, 
                                 :priority, 
                                 :user_id,
                                 label_ids: [] )
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
