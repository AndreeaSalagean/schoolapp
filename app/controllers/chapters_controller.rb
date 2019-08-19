class ChaptersController < ApplicationController
	before_action :set_course, only: [:index, :new, :create, :destroy]
	
	def index
		@chapters = @course.chapters
	end

	def show
   	@chapter = Chapter.find(params[:id])
   	@course = @chapter.course
   	@assignments = @chapter.assignments
   	@resources = @chapter.resources
	end

	def new
	end

	def create
		@chapter = @course.chapters.create(chapter_params)

    unless @chapter.save
      flash[:error] = @chapter.errors.full_messages.first
      redirect_to action: 'new'
      return
    end
		redirect_to course_path(@course)
	end

	def destroy
    @chapter = @course.chapters.find(params[:id])
    @chapter.destroy
    redirect_to course_chapters_path(course_id: @course.id)
  end

	private
    def chapter_params
		  params.require(:chapter).permit(:title, :body)
	  end

	  def set_course
		  @course = Course.find(params[:course_id])
	 end
end
