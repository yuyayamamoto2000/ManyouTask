class AddTimeLimitsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :time_limit, :datetime, null: false, default: -> { 'NOW()' }
  end
end
