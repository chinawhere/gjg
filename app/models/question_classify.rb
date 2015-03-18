class QuestionClassify < ActiveRecord::Base
  attr_accessible :name, :parent_id
  scope :top_category, ->{where(:parent_id => nil)}
end
