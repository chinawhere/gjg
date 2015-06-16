class CreateUsersEvents < ActiveRecord::Migration
  def change
    create_table :events_users do |t|
      t.belongs_to :event, index: true
      t.belongs_to :user, index: true
    end
  end
end
