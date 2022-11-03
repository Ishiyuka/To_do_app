class TasksController < ApplicationController
  before_action :set_task, only: %I[ show edit update destroy]

  def index
    @tasks = Task.all.page(params[:page])
    if params[:task_search].present?
      list = params[:task_search][:list]
      status = params[:task_search][:status]
      if (list && status).present?
        @tasks = @tasks.page(params[:page]).search_list_status(list, status)
      elsif list.present?
        @tasks = @tasks.page(params[:page]).search_list(list)
      elsif status.present?
        @tasks = @tasks.page(params[:page]).search_status(status)
      end
    elsif params[:sort_deadline]
      @tasks = @tasks.page(params[:page]).deadline_list
    elsif params[:sort_priority]
      @tasks = @tasks.page(params[:page]).priority_list
    else params[:sort_created_at]
      @tasks = @tasks.page(params[:page]).created_list
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
