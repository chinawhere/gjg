class ChangeGlobalIdFieldForPlayer < ActiveRecord::Migration
  def change
  	change_column :players, :global_id, :string
  end
end
