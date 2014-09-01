class AddHobbyToUser < ActiveRecord::Migration
  def change
    add_column :users, :hobby, :string
  end
end
