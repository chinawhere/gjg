class Question < ActiveRecord::Base
  attr_accessible :a, :answer, :b, :c, :d, :question_classify_id, :title
  ANSWER = {a: 'A', b: 'B', c: 'C', d: 'D'}
  def classify
  	QuestionClassify.find(self.question_classify_id).try(:name)
  end
end
