class AddWeightToEvnets < ActiveRecord::Migration
  def change
    add_column :events, :weight, :integer, default: 0
  end
end
