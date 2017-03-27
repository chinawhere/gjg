class AddStartTimeToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :start_time, :string
  end
end
