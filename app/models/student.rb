class Student < ApplicationRecord
  has_many :student_courses
  has_many :course_scores

  validates_uniqueness_of :number
  validates_presence_of :number, :cn_name, :en_name, :grade
end
