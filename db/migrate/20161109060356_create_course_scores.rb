class CreateCourseScores < ActiveRecord::Migration[5.0]
  def change
    create_table :course_scores do |t|
      t.integer :student_id
      t.integer :course_id
      t.integer :category
      t.date :date
      t.string :value
      t.float :score

      t.timestamps
    end
  end
end
