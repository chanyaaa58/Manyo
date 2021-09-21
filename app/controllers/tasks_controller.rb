class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort_expired]
      @tasks = Task.all.order("expired_at")
    elsif params[:sort_priority]
      @tasks = Task.all.order("priority")
    else
      @tasks = Task.all.order(created_at: :desc)
      # binding.irb
    end
    if params[:search].present?
      if params[:search][:list].present? && params[:search][:status].present?
        @tasks = Task.where('list LIKE ?', "%#{params[:search][:list]}%").where(status: params[:search][:status])

      elsif params[:search][:list].present?
        @tasks = Task.where('list LIKE ?', "%#{params[:search][:list]}%")
        
      elsif params[:search][:status].present?
        @tasks = Task.where(status: params[:search][:status])
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを登録しました！"
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
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました！"
  end

  private
  def task_params
    params.require(:task).permit(:list, :detail, :expired_at, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
