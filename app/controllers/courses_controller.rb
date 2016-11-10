class CoursesController < ApplicationController
  before_action :set_course

  def show
    @student_courses = @course.student_courses.includes(:student).order(total_score: :desc)
    total_score_arr = @student_courses.map(&:total_score).compact
    len = total_score_arr.count.to_f
    @average_total_score = (total_score_arr.reduce(:+) / len).round
    sorted = total_score_arr.sort
    @median_total_score = (len % 2 == 1 ? sorted[len/2] : (sorted[len/2 - 1] + sorted[len/2]).to_f / 2)
  end

  CourseScore::CategoriesDict.each_pair do |method_name, category|
    define_method method_name do
      @category = method_name
      @category_name = category
      @score_set = @course.course_scores.where(category: category).includes(:student).order(:student_id, :index)
      @max_index = @score_set.maximum(:index)
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
