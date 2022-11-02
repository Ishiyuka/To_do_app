class TasksController < ApplicationController
  before_action :set_task, only: %I[ show edit update destroy]

  def index
    if params[:task].present?
      title = params[:task][:titile]
      status = params[:task][:status]
      if (title && status).present?
        @tasks = Task.search_title_status(title, status)
      elsif title.present?
        @tasks = Task.search_title(title)
      elsif status.present?
        @tasks = Task.search_status(status)
      end
    elsif params[:sort_deadline].present?
      @tasks = Task.deadline_list
    elsif params[:sort_priority].present?
      @tasks = Task.priority_list
    # elsif
      # @tasks = created_list
    else
      @tasks = Task.page(prams[:page]).per(5)
    end
  end

  scope :created_list, ->{order(created_at: :desc)}
  scope :deadline_list, ->{order(deadline: :desc)}
  scope :priority_list, ->{order(priority: :asc)}
  scope :title_status, ->(title,status) { where("title LIKE ? ", "%#{title}%").where(status:status) }
  scope :search_title, ->(title) { where("title LIKE(?) ", "%#{title}%") }
  scope :search_status,

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
