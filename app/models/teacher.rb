class Teacher < ApplicationRecord
  validates_uniqueness_of :number
  validates_presence_of :number, :name, :en_name, :email
end
