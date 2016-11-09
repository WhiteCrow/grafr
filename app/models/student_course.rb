class StudentCourse < ApplicationRecord
  belongs_to :student
  belongs_to :course

  validates_presence_of :student_id, :course_id
  validates_uniqueness_of :student_id, scope: :course_id

  # score_category: ["attendence", "class_performance", "homework", "quiz", "mid_term"]
  def recalculate(score_category)
    category = CourseScore::CategoriesDict[score_category]
    raise Exception.new("Wrong Type") if category.nil?

    sources = CourseScore.where(category: category, course_id: course_id, student_id: student_id).map(&:score)
    result = (sources.reduce(:+).to_f / sources.count).round

    self.update!(score_category => result)
    result
  end

  def self.calculate(score_category, course_id, student_id)
    instance = StudentCourse.find_by!(course_id: course_id, student_id: student_id)
    instance.attributes[score_category] || instance.recalculate(score_category)
  end

  #def calculate(score_category)
  #  StudentCourse.calculate(score_category, self.course_id, self.student_id)
  #end

end
