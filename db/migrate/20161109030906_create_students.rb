class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.integer :number
      t.string :cn_name
      t.string :en_name
      t.integer :grade

      t.timestamps
    end
  end
end
