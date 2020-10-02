class AddToDoToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :to_do, :integer, default: 0
  end
end
