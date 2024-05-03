class CoursesController < ApplicationController
  def index
  end

  def create
    course = Course.new(course_params)
    if course.save
      render json: course, serializer: CourseSerializer, status: :created
    else
      render json: course.errors, status: :unprocessable_entity
    end
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :duration, :price, :level, 
      tutors_attributes: [:name, :email, :about, :experience, :specialization])
  end
end
