class CreateTeachers < ActiveRecord::Migration[5.0]
  def change
    create_table :teachers do |t|
      t.string :number
      t.string :name
      t.string :email
      t.string :cn_name
      t.string :en_name

      t.timestamps
    end
  end
end
