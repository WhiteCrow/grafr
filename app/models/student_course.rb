class StudentCourse < ApplicationRecord
  belongs_to :student
  belongs_to :course

  validates_presence_of :student_id, :course_id
  validates_uniqueness_of :student_id, scope: :course_id
end
