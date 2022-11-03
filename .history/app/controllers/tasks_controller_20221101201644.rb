class TasksController < ApplicationController
  before_action :set_task, only: %I[ show edit update destroy]

  def search
    @tasks = Task.where('title LIKE ?', "%#{params[:tasks]}%").present?
  end

  def index
    if params[:task].present?
      title = params[:task][:titile]
      status = params[:task][:status]
      if (title && status).present?
        @tasks = Task.title_status(title, status)
      elsif title.present?
        @tasks = Task.search_title(title)
      elsif status.present?
        @tasks = Task.search_status(status)
      end
      @tasks = Task.all.order(deadline: "ASC") if params[:sort_deadline].present?
      @tasks = Task.all.order(priority: "ASC") if params[:sort_priority].present?
      @tasks = Task.all.order(created_at: "DESC")
    end
  end

  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def create
    # @task = current_user.tasks.build(task_params)
    @task = Task.create(task_params)
    if @task.save
      flash[:notice] = "新規作成しました"
      redirect_to tasks_path
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
      flash[:notice] = "編集しました"
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:alert] = "削除しました"
    redirect_to tasks_path
  end
  private

  def task_params
    params.require(:task).permit(:list, :detail, :status, :priority, :deadline)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
