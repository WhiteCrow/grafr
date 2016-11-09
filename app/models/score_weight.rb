class ScoreWeight < ApplicationRecord
  validates_uniqueness_of :course_number
  validates_presence_of :course_number, :attendence, :class_performance, :homework, :quiz, :mid_term, :final_term

end
