class Teacher < ApplicationRecord
  has_many :teacher_courses
  has_many :courses, through: :teacher_courses

  validates_uniqueness_of :number
  validates_presence_of :number, :name, :en_name, :email
end
