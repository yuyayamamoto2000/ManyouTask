class ChangeNotNullPrioritiesToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :priority, false, "未着手"
  end
end
