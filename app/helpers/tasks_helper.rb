module TasksHelper
  def confirm_new_or_edit
    if action_name == 'new' || action_name == 'create'
      confirm_tasks_path
    elsif action_name == 'edit' || action_name == 'update'
      #confirm_task_path(@task.id)
      task_path
    end
  end
end
