class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.integer :question_classify_id
      t.string :a
      t.string :b
      t.string :c
      t.string :d
      t.string :answer

      t.timestamps
    end
  end
end
