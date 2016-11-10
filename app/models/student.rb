class Student < ApplicationRecord
  has_many :student_courses
  has_many :course_scores
  has_many :courses, through: :course_scores

  validates_uniqueness_of :number
  validates_presence_of :number, :cn_name, :en_name, :grade

  scope :grade, ->(grade){where(grade: grade).includes(:student_courses)}

  def total_score_by(course_id_period_dict)
    #course_id_period_dict = courses.to_a.map{|c| {c.id => c.period}}.reduce(:merge)

    score_sum = weight_sum = 0
    self.student_courses.each do |sc|
      if sc.total_score.present?
        weight = course_id_period_dict[sc.course_id]
        score = sc.total_score * weight
        score_sum = score_sum + score
        weight_sum = weight_sum + weight
      end
    end
    (score_sum.to_f / weight_sum).round
  end
end
