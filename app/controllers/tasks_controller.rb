class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = current_user.tasks
    if params[:search] && params[:search][:title].present?
      #if params[:search][:title].present? && params[:search][:priority].present?
      @tasks = Task.title_search(params[:search][:title]).priority_search(params[:search][:priority])
      #elsif params[:search][:title].present?
      #@tasks = Task.title_search(params[:search][:title])#ここであいまい検索のパラメーターを受け取る

    elsif params[:search] && params[:search][:priority].present?
      @tasks = Task.priority_search(params[:search][:priority])
    end
    if params[:sort_to_do] == "true"
      @tasks = @tasks.order(to_do: "ASC")
      # else
      #   @tasks = @tasks.order(to_do: "DESC")
    elsif params[:sort_expired] == "true"
      @tasks = @tasks.order(time_limit: "DESC")
    end
    #@tasks = @tasks.order(id: "DESC")
    @tasks = @tasks.order(id: "DESC").page(params[:page]).per(5)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: t('controller.add_task')
      else
        flash.now[:danger] = t('controller.add_failure')
        render :new
      end
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('controller.edit_task')
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('controller.delete_task')
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :time_limit, :priority, :to_do)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
