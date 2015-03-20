class AddCityCodeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :city_code, :string
  end
end
