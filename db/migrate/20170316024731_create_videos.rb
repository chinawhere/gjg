class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :zkey
      t.string :zurl
      t.string :lkey
      t.string :lurl
      t.string :name
      t.string :desc

      t.timestamps null: false
    end
  end
end
