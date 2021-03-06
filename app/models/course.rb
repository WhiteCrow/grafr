class Course < ApplicationRecord
  has_many :course_scores
  has_many :student_courses

  validates_uniqueness_of :number
  validates_presence_of :number, :name, :subject, :period
end
