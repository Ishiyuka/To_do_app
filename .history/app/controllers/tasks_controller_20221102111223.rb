class TasksController < ApplicationController
  before_action :set_task, only: %I[ show edit update destroy]

  def index
    @tasks = Task.all
    if params[:task_search].present?
      title = params[:task_search][:titile]
      status = params[:task_search][:status]
      if (title && status).present?
        byebug
        @tasks = @tasks.search_title_status(title, status)
      elsif title.present?
        @tasks = @tasks.search_title(title)
      elsif status.present?
        @tasks = @tasks.search_status(status)
      end
    elsif params[:sort_deadline]
      @tasks = @tasks.order(deadline: :desc)
    elsif params[:sort_priority]
      @tasks = @tasks.order(priority: :asc)
    else
      @tasks = @tasks.order(created_at: :desc)
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
