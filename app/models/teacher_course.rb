class TeacherCourse < ApplicationRecord
  belongs_to :teacher
  belongs_to :course

  validates_presence_of :teacher_id, :course_id
  validates_uniqueness_of :teacher_id, scope: [:course_id]
end
