class AddTotalScoreToStudentCourse < ActiveRecord::Migration[5.0]
  def change
    add_column :student_courses, :total_score, :integer
  end
end
