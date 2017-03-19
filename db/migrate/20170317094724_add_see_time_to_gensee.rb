class AddSeeTimeToGensee < ActiveRecord::Migration
  def change
    add_column :gensees, :see_time, :integer
  end
end
