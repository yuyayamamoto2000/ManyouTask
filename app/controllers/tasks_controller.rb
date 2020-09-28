class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    # @tasks = Task.all
    if params[:sort_expired] == "true"
      @tasks = Task.all.order(time_limit: "DESC")
      # elsif params[:search][:title].present?
      #   @tasks = Task.where('title like ?',"%#{params[:search][:title]}%")#ここであいまい検索のパラメーターを受け取る
      # elsif params[:search][:priority].present?
      #   @tasks = Task.where(priority: params[:priority])
    else
      @tasks = Task.all.order(created_at: "DESC")
      # @tasks.where('title like ?','%params[:search]%') if params[:search][:title].present?
    end
    if params[:search][:title].present? && params[:search][:priority].present?
    elsif params[:search][:title].present?
      @tasks = Task.where('title like ?',"%#{params[:search][:title]}%")#ここであいまい検索のパラメーターを受け取る
    elsif params[:search][:priority].present?
      @tasks = Task.where('priority like ?',"%#{params[:search][:priority]}%")#
    end
  end


  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
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
    params.require(:task).permit(:title, :content, :time_limit, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def user_search_params

  end
end
