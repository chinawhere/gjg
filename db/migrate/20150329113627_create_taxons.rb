class CreateTaxons < ActiveRecord::Migration
  def change
    create_table :taxons do |t|
      t.string :name
      t.integer :position
      t.integer :parent

      t.timestamps null: false
    end
  end
end
