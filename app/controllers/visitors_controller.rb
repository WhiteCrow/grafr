class VisitorsController < ApplicationController
  def index
    @courses = Course.all.order(:number)
    @students = Student.all
  end
end
