class StudentsController < ApplicationController

  def show
    @student = Student.find(params[:id])
    @student_courses = @student.student_courses.includes(:course)
    @courses = @student_courses.map(&:course).uniq
    @total_period = @courses.map(&:period).reduce(:+)
    @course_id_period_dict = @courses.to_a.map{|c| {c.id => c.period}}.reduce(:merge)
    @student.total_gpa = @student.total_gpa_by(@course_id_period_dict)
    render layout: false
  end
end
