class AddIndexes < ActiveRecord::Migration[5.0]
  def change
    add_index :students, :cn_name
    add_index :course_scores, :student_id
    add_index :course_scores, :course_id
    add_index :course_scores, :category
  end
end
