class QuestionClassify < ActiveRecord::Base
  scope :top_category, ->{where(:parent_id => nil)}
end
