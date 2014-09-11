class AddWeixinIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :weixin_id, :string
  end
end