class CreateSlideAds < ActiveRecord::Migration
  def change
    create_table :slide_ads do |t|
      t.string :title
      t.string :link
      t.string :img

      t.timestamps null: false
    end
  end
end
