class CreateQuestionClassifies < ActiveRecord::Migration
  def change
    create_table :question_classifies do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
  end
end
