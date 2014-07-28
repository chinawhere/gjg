# coding: utf-8
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :email
      t.string  :password
      t.string  :sex
      t.string  :mobile
      t.string  :logo
      t.string  :position
      t.integer :age
      t.string  :qq
      t.timestamps
    end

    add_index :users, [:email, :password]
  end
end
