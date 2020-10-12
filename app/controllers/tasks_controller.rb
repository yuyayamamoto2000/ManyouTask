class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :current_user
  before_action :authenticate_user
  before_action :logged_in?

  def index
    @tasks = current_user.tasks
    if params[:search] && params[:search][:title].present? && params[:search][:priority].present? && params[:search][:label_id].present? #全部検索
      @tasl_labels = TaskLabel.where(label_id: params[:search][:label_id]).pluck(:task_id)
      @tasks = Task.title_search(params[:search][:title]).priority_search(params[:search][:priority]).where(id: @tasl_labels)

    elsif params[:search] && params[:search][:title].present? && params[:search][:priority].present? #タイトルとプライオリティ
      @tasks = Task.title_search(params[:search][:title]).priority_search(params[:search][:priority])

    elsif params[:search] && params[:search][:title].present? && params[:search][:label_id].present? #タイトルとラベル
      @tasl_labels = TaskLabel.where(label_id: params[:search][:label_id]).pluck(:task_id)
      @tasks = Task.title_search(params[:search][:title]).where(id: @tasl_labels)

    elsif params[:search] && params[:search][:label_id].present? && params[:search][:priority].present? #ラベルとプライオリティ
      # @tasks = Task.priority_search(params[:search][:priority]).join(:task_labels).where(task_labels: { id: params[:serch][:label_ids] }).uniq
      # @tasks = Task.pluck(:label_id).joins.where('task_labels.label_id = ?', params[:label_id])
      @tasl_labels = TaskLabel.where(label_id: params[:search][:label_id]).pluck(:task_id)
      @tasks = Task.priority_search(params[:search][:priority]).where(id: @tasl_labels)

    elsif params[:search] && params[:search][:priority].present? #プライオリティのみ
      @tasks = Task.priority_search(params[:search][:priority])
      # @tasks = Task.where(params[:search][:task_id])
    elsif params[:search] && params[:search][:title].present? #タイトルのみ
        #if params[:search][:title].present? && params[:search][:priority].present?
          @tasks = Task.title_search(params[:search][:title])
    elsif params[:search] && params[:search][:label_id].present? # ラベルのみ
      @tasl_labels = TaskLabel.where(label_id: params[:search][:label_id]).pluck(:task_id)
      @tasks = Task.where(id: @tasl_labels)
    end
    if params[:sort_to_do] == "true"
      @tasks = @tasks.order(to_do: "ASC")
      # else
      #   @tasks = @tasks.order(to_do: "DESC")
    elsif params[:sort_expired] == "true"
      @tasks = @tasks.order(time_limit: "DESC")
    end
    #@tasks = @tasks.order(id: "DESC")
    @kaminari = @tasks.order(id: "DESC").page(params[:page]).per(5)
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
    params.require(:task).permit(:title, :content, :time_limit, :priority, :to_do, { label_ids: [] })
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
