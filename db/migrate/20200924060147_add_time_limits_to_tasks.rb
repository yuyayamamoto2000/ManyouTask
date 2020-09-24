class AddTimeLimitsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :time_limit, false, Datetime.now
  end
end
