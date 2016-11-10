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
    if sources.blank?
      return puts "no sources"
    end
    result = (sources.reduce(:+).to_f / sources.count).round

    self.update!(score_category => result)
    result
  end

  def self.calculate(score_category, course_id, student_id)
    instance = StudentCourse.find_by!(course_id: course_id, student_id: student_id)
    instance.attributes[score_category] || instance.recalculate(score_category)
  end

  def update_total_score!
    course = Course.find(course_id)
    weight = ScoreWeight.find_by_course_number!(course.number)

    _total_wight = _total_score = 0
    CourseScore::CategoriesDict.keys.map do |category|
      score = attributes[category]
      _weight = weight.attributes[category]
      _weight = _weight * 2 if category == "mid_term"
      if score.present?
        _total_wight = _total_wight + _weight
        _total_score = (_total_score + score * _weight)
      end
    end
    if _total_wight ==  0
      return puts "no scores"
    end
    result = (_total_score.to_f / _total_wight).round
    self.update!(total_score: result)
    result
  end

  #def calculate(score_category)
  #  StudentCourse.calculate(score_category, self.course_id, self.student_id)
  #end

  def gpa
    if total_score >= 90;    return 4
    elsif total_score >= 85; return 3.7
    elsif total_score >= 82; return 3.3
    elsif total_score >= 78; return 3.3
    elsif total_score >= 75; return 2.7
    elsif total_score >= 72; return 2.3
    elsif total_score >= 68; return 2
    elsif total_score >= 64; return 1.5
    elsif total_score >= 60; return 1
    else; return 0
    end
  end

end
