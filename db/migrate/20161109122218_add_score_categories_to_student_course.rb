class AddScoreCategoriesToStudentCourse < ActiveRecord::Migration[5.0]
  def change
    add_column :student_courses, :attendence, :integer
    add_column :student_courses, :class_performance, :integer
    add_column :student_courses, :homework, :integer
    add_column :student_courses, :quiz, :integer
    add_column :student_courses, :mid_term, :integer
  end
end
