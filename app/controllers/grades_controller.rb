class GradesController < ApplicationController
  def show
    @grade = params[:id].to_i
    grade_string = (@grade / 10 == 1) ? @grade.to_s : "0#{@grade}"
    @courses = Course.grade(grade_string)
    @students = Student.grade(@grade).includes(:student_courses)
    @course_id_period_dict = @courses.to_a.map{|c| {c.id => c.period}}.reduce(:merge)
  end
end
