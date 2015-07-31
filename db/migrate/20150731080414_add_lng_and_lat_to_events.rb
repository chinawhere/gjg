class AddLngAndLatToEvents < ActiveRecord::Migration
  def change
    add_column :events, :lng, :float
    add_column :events, :lat, :float
  end
end
