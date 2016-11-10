class Student < ApplicationRecord
  has_many :student_courses
  has_many :course_scores
  has_many :courses, through: :course_scores
  attr_accessor :total_gpa

  validates_uniqueness_of :number
  validates_presence_of :number, :cn_name, :en_name, :grade

  scope :grade, ->(grade){where(grade: grade).includes(:student_courses)}

  def total_gpa_by(course_id_period_dict)
    #course_id_period_dict = courses.to_a.map{|c| {c.id => c.period}}.reduce(:merge)

    gpa_sum = weight_sum = 0
    self.student_courses.each do |sc|
      if sc.total_score.present?
        weight = course_id_period_dict[sc.course_id]
        gpa = sc.gpa * weight
        gpa_sum = gpa_sum + gpa
        weight_sum = weight_sum + weight
      end
    end
    return 0 if weight_sum == 0
    (gpa_sum.to_f / weight_sum).round(2)
  end
end
