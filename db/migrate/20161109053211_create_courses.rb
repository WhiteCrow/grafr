class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :number
      t.string :name
      t.string :subject
      t.integer :period

      t.timestamps
    end
  end
end
