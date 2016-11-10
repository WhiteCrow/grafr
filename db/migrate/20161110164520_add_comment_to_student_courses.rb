class AddCommentToStudentCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :student_courses, :comment, :text
  end
end
