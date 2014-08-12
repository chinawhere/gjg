class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :event_id
      t.string :name
      t.string :avatar
      t.timestamps
    end

    add_column :events, :photos_path, :string
  end
end
