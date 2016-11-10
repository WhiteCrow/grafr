class GradesController < ApplicationController
  def show
    @grade = params[:id].to_i
    grade_string = (@grade / 10 == 1) ? @grade.to_s : "0#{@grade}"
    @courses = Course.grade(grade_string)
    # 9年纪的黄睿琳上11年级的英语课，特殊处理
    if @grade == 9
      @courses = @courses.to_a << Course.find(51)
      @courses = @courses << Course.find(52)
    end
    students = Student.grade(@grade).includes(:student_courses)
    @course_id_period_dict = @courses.to_a.map{|c| {c.id => c.period}}.reduce(:merge)

    students.each do |s|
      s.total_gpa = s.total_gpa_by(@course_id_period_dict)
    end
    @students = students.to_a.sort{ |a,b| a.total_gpa <=> b.total_gpa }.reverse
  end
end
