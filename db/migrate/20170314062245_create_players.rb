class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :username
      t.integer :global_id
      t.string :mobile
      t.string :email
      t.string :sex

      t.timestamps null: false
    end
  end
end
