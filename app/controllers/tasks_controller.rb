class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort_to_do] == "true"
      @tasks = Task.all.order(to_do: "ASC")
    else
      @tasks = Task.all.order(to_do: "DESC")
      if params[:sort_expired] == "true"
        @tasks = Task.all.order(time_limit: "DESC")
      else
        @tasks = Task.all.order(created_at: "DESC")
        if params[:search]
          if params[:search][:title].present? && params[:search][:priority].present?
            @tasks = Task.title_search(params[:search][:title]).priority_search(params[:search][:priority])
          elsif params[:search][:title].present?
            @tasks = Task.title_search(params[:search][:title])#ここであいまい検索のパラメーターを受け取る
          elsif params[:search][:priority].present?
            @tasks = Task.priority_search(params[:search][:priority])
          end
        end
      end
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
    params.require(:task).permit(:title, :content, :time_limit, :priority, :to_do)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
