class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer   :user_id
      t.integer   :category_id
      t.string    :name
      t.string    :address
      t.string    :logo
      t.datetime  :start_at
      t.datetime  :end_at
      t.integer   :fee_type
      t.string    :fee
      t.integer   :max_count
      t.integer   :min_count
      t.integer   :approved, default: 0
      t.text      :content
      t.timestamps
    end
  end
end
