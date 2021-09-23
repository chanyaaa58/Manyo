class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all.order(created_at: :desc)
   
    @tasks = @tasks.reorder(expired_at: :desc) if params[:sort_expired]
    @tasks = @tasks.reorder("priority") if params[:sort_priority]
    
    #タイトル名・ステータスの検索
    @tasks = @tasks.search_by_list(params[:list]) if params[:list].present?
    @tasks = @tasks.search_by_status(params[:status]) if params[:status].present?

    # if params[:search].present?
      # if params[:list].present? && params[:status].present?
      #   #title and statusの両方が成り立つ検索結果を返す
      #   @tasks = Task.search_by_list_and_status
      # #渡されたパラメータがtask titleのみだったとき
      # elsif params[:list].present?
      #   @tasks = Task.search_by_list
      # #渡されたパラメータがステータスのみだったとき
      # elsif params[:status].present?
      #   @tasks = Task.search_by_status
      # end
    #↓モデルにscopeで定義する前のコード    
    # #タイトル名・ステータスの検索
    # if params[:search].present?
    #   if params[:search][:list].present? && params[:search][:status].present?
    #     #title and statusの両方が成り立つ検索結果を返す
    #     @tasks = Task.where('list LIKE ?', "%#{params[:search][:list]}%").where(status: params[:search][:status])
    #   #渡されたパラメータがtask titleのみだったとき
    #   elsif params[:search][:list].present?
    #     @tasks = Task.where('list LIKE ?', "%#{params[:search][:list]}%")
    #   #渡されたパラメータがステータスのみだったとき
    #   elsif params[:search][:status].present?
    #     @tasks = Task.where(status: params[:search][:status])

    # end
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
