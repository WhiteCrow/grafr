class Student < ApplicationRecord
  validates_uniqueness_of :number
  validates_presence_of :number, :cn_name, :en_name, :grade
end
