class Course < ApplicationRecord
  has_many :course_scores

  validates_uniqueness_of :number
  validates_presence_of :number, :name, :subject, :period
end
