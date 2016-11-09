class CourseScore < ApplicationRecord
  belongs_to :student
  belongs_to :course

  validates_presence_of :student_id, :course_id, :category, :index, :value
  validates_uniqueness_of :student_id, scope: [:course_id, :category, :index]

  CategoriesDict = {
    "attendence" => "Attendence",
    "class_performance" => "Class Performance",
    "homework" => "Homework",
    "quiz" => "Quiz",
    "mid_term" => "Mid-Term"
  }
  Categories = CategoriesDict.values
  enum category: Categories

  AttendenceScoring = {
    "Attend" => 100,
    "Late"   => 50,
    "Miss"   => 0,
    "Leave"  => 100,
    "Sick"   => 100
  }

  ClassPerformanceScoring = {
    "A" => 100,
    "B" => 80,
    "C" => 60,
    "D" => 40,
    "E" => 20
  }

  def score
    if category == "Attendence"
      AttendenceScoring[value]
    elsif category == "Attendence"
      ClassPerformanceScoring[value]
    else
      value
    end
  end
end
