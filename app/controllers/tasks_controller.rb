class TasksController < ApplicationController
  before_action :set_task, only: %I[ show edit update destroy]
  skip_before_action :login_required, only: %I[ new create]
  skip_before_action :already_logged_in, only: %I[ index new create update show edit destroy ]
  skip_before_action :no_access_to_others, only: %I[ index new create update show edit destroy]
  skip_before_action :if_not_admin, only: %I[ index new create update show edit destroy]


  def index
    @tasks = current_user.tasks.page(params[:page]).per(2)
    if params[:task_search].present?
      list = params[:task_search][:list]
      status = params[:task_search][:status]
      label = params[:task_search][:label_id]
      if (list && status).present?
        @tasks = @tasks.search_list_status(list, status)
      elsif list.present?
        @tasks = @tasks.search_list(list)
      elsif status.present?
        @tasks = @tasks.search_status(status)
      elsif label.present?
        @tasks = @tasks.search_label(label)
      end
    elsif params[:sort_deadline]
      @tasks = @tasks.deadline_list
    elsif params[:sort_priority]
      @tasks = @tasks.priority_list
    else
      @tasks = @tasks.created_list
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
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:list, :detail, :status, :priority, :deadline, :user_id, { label_ids: [] })
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

end
