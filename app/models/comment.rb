# coding: utf-8
class Comment < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :commentable, polymorphic: true

  belongs_to :user
  scope :p_comments, where(:p_comment_id => nil)

  def r_comments
    self.class.where(:p_comment_id => self.id)
  end
end
