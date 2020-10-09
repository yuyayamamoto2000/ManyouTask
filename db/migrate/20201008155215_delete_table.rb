class DeleteTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :labellings
  end
end
