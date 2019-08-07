class ChaptersController < ApplicationController
	
	def index
		@course = Course.find(params[:course_id])
		@chapters = @course.chapters
	end

	def show
   		@chapter = Chapter.find(params[:id])
   		@course = @chapter.course
   		@assignments = @chapter.assignments
	end

	def new
		@course = Course.find(params[:course_id])
	end

	def create
	
		@course = Course.find(params[:course_id])
		@chapter = @course.chapters.create(chapter_params)

    unless @chapter.save
      flash[:error] = @chapter.errors.full_messages.first
      redirect_to action: 'new'
      return
    end
		redirect_to course_path(@course)

	end

	private

	def chapter_params
		params.require(:chapter).permit(:title, :body)

	end
end
