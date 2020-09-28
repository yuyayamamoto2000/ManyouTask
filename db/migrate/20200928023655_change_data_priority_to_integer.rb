class ChangeDataPriorityToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :priority, :string
  end
end
