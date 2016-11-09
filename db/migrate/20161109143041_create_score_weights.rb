class CreateScoreWeights < ActiveRecord::Migration[5.0]
  def change
    create_table :score_weights do |t|
      t.string :course_number
      t.integer :attendence
      t.integer :class_performance
      t.integer :homework
      t.integer :quiz
      t.integer :mid_term
      t.integer :final_term

      t.timestamps
    end
  end
end
