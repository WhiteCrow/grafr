class Course < ApplicationRecord
  has_many :course_scores
  has_many :student_courses

  validates_uniqueness_of :number
  validates_presence_of :number, :name, :subject, :period

  scope :grade, ->(grade){where("number LIKE '201601G#{grade}%'")}

  def del
    css = StudentCourse.where(course_id: self.id)
    scs = CourseScore.where(course_id: self.id)

    css.destroy_all
    puts "StudentCourse count" + css.count.to_s
    scs.destroy_all
    puts "CourseScore count" + scs.count.to_s
  end
end
