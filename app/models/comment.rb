# coding: utf-8
class Comment < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :commentable, polymorphic: true
end
