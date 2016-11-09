class CoursesController < ApplicationController
  before_action :set_course

  CourseScore::CategoriesDict.each_pair do |method_name, category|
    define_method method_name do
      @category = category
      @source_set = @course.course_scores.where(category: category).includes(:student).order(:student_id, :index)
      @max_index =  @source_set.maximum(:index)
      render :source_set
    end
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

end
