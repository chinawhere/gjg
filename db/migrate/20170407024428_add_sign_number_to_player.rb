class AddSignNumberToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :sign_number, :integer, default: 0
  end
end
