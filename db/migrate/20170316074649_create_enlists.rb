class CreateEnlists < ActiveRecord::Migration
  def change
    create_table :enlists do |t|
      t.integer :player_id
      t.string :name
      t.string :qq
      t.string :company
      t.string :address
      t.string :mobile

      t.timestamps null: false
    end
  end
end
