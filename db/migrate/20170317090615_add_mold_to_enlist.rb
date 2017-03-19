class AddMoldToEnlist < ActiveRecord::Migration
  def change
    add_column :enlists, :mold, :string
  end
end
