class ChangeNotNullTimeLimitsToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :time_limit, false, DateTime.now
  end
end
