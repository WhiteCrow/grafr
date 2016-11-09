class CourseScore < ApplicationRecord
  belongs_to :student
  belongs_to :course

  validates_presence_of :student_id, :course_id, :category, :index, :value
  validates_uniqueness_of :student_id, scope: [:course_id, :category, :index]

  Categories = ["Attendence", "Class Performance", "Homework", "Quiz", "Mid-Term"]
  enum category: Categories
end
