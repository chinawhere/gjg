class AddProvinceToEnlist < ActiveRecord::Migration
  def change
    add_column :enlists, :province, :string
    add_column :enlists, :training_time, :string
    add_column :enlists, :skill_one, :boolean, default: false
    add_column :enlists, :skill_two, :boolean, default: false

    add_column :enlists, :sign_number, :integer, default: 0
  end
end
