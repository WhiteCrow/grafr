class RemoveScoreFromCourseScore < ActiveRecord::Migration[5.0]
  def change
    remove_column :course_scores, :score
  end
end
