class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all.order(created_at: :desc)
    # 1ページに表示するレコード数は10件
    @tasks = Task.all.page(params[:page]).per(10)

    @tasks = @tasks.reorder(expired_at: :desc) if params[:sort_expired]
    @tasks = @tasks.reorder("priority") if params[:sort_priority]

    #タイトル名・ステータスの検索
    @tasks = @tasks.search_by_list(params[:list]) if params[:list].present?
    @tasks = @tasks.search_by_status(params[:status]) if params[:status].present?
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
