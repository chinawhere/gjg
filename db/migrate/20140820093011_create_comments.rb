class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer   :user_id
      t.integer   :to_user_id
      t.integer   :reply_to_user_id
      t.integer   :reply_to_comment_id
      t.text   :content
      t.integer   :p_user_id
      t.integer   :p_comment_id
      t.integer   :commentable_id
      t.string   :commentable_type
      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :p_comment_id
    add_index :comments, [:commentable_id, :commentable_type], name: 'commentable'

  end
end
