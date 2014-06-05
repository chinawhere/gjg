class CreateApplies < ActiveRecord::Migration
  def change
    create_table :applies do |t|
      t.integer   :user_id
      t.integer   :event_id
      t.string    :name
      t.string    :email
      t.integer   :age
      t.string    :sex
      t.integer   :approved, default: 0
      t.timestamps
    end
  end
end
