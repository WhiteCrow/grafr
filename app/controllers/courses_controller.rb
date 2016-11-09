class CoursesController < ApplicationController
  before_action :set_course

  def show
    @student_courses = @course.student_courses.includes(:student)
  end

  CourseScore::CategoriesDict.each_pair do |method_name, category|
    define_method method_name do
      @category = method_name
      @category_name = category
      @score_set = @course.course_scores.where(category: category).includes(:student).order(:student_id, :index)
      @max_index =  @score_set.maximum(:index)
      render :score_set
    end
  end

  def recalculate_score
    category = params[:category]
    student_id = params[:student_id]
    course_id = @course.id
    sc = StudentCourse.find_by!(course_id: course_id, student_id: student_id)
    sc.recalculate(category)
    redirect_to "/courses/#{course_id}/#{category}"
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

end
