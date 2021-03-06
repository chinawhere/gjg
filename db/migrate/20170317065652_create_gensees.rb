class CreateGensees < ActiveRecord::Migration
  def change
    create_table :gensees do |t|
      t.integer :uid, :limit => 11
      t.string :area
      t.string :company
      t.integer :joinTime, :limit => 11
      t.integer :leaveTime, :limit => 11
      t.string :nickname
      t.string :mobile
      t.integer :device
      t.string :ip
      t.string :name
      t.integer :video_id
      t.string :mold
      t.string :sdk

      t.timestamps null: false
    end
  end
end
