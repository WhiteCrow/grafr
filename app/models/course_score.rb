class CourseScore < ApplicationRecord
  validates_presence_of :student_id, :course_id, :category, :date, :value
end
