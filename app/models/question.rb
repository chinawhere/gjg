class Question < ActiveRecord::Base
  ANSWER = {a: 'A', b: 'B', c: 'C', d: 'D'}
  def classify
  	QuestionClassify.find(self.question_classify_id).try(:name)
  end
end
