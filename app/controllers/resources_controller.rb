class ResourcesController < ApplicationController
  before_action :set_course, only: [:new, :index]
  before_action :set_chapter, only: [:new]

  def index
    @course = Course.find(params[:course_id])
  	@resources = @course.resources
  end

  def new
  	@resource = Resource.new
    session[:course_id] = @course.id
    session[:chapter_id] = @chapter.id
  end

  def create
  	@resource = Resource.create(resource_params)
  	@resource.course_id = session[:course_id]
  	@resource.chapter_id = session[:chapter_id]
 	  if @resource.save!   
      redirect_to course_chapter_path(course_id: session[:course_id],id: session[:chapter_id]), notice: "Successfully uploaded."   
    else   
      render "new"   
    end
  end

  def destroy
  	@resource = Resource.find(params[:id])   
    @resource.destroy   
    redirect_to resources_path, notice:  "Successfully deleted."
  end

  private   
    def resource_params   
      params.require(:resource).permit(:name, :attachment)   
    end   

     def set_course 
      @course = Course.find(params[:course_id])
    end

    def set_chapter 
      @chapter = Chapter.find(params[:chapter_id])
    end
end
