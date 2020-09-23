class TaskConstraint < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :title, false, "未記入"
    change_column_null :tasks, :content, false, "未記入"
  end
end
