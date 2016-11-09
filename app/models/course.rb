class Course < ApplicationRecord
  validates_uniqueness_of :number
  validates_presence_of :number, :name, :subject, :period
end
