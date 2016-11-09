class VisitorsController < ApplicationController
  def index
    @courses = Course.all.order(:name)
  end
end
