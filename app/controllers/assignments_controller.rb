class AssignmentsController < ApplicationController\

	def index
		@course = Course.find(params[:course_id])
		@assignments = @course.assignments
	end


	def show
		@course = Course.find(params[:course_id])
   		@assignment = Assignment.find(params[:id])
	end

	def new
		@course = Course.find(params[:course_id])
		@chapter = Chapter.find(params[:chapter_id])
	end

	def create_assignment
		
		@course = Course.find(params[:course_id])
		@chapter = Chapter.find(params[:chapter_id])

		@assignment = @chapter.assignments.create(title: params[:title])
		@assignment.due_date = params[:trip_start]
		@assignment.submission = false

		 unless @assignment.save
     		 flash[:error] = @assignment.errors.full_messages.first
      		 redirect_to action: 'new'
      		 return
   		 end

		redirect_to course_chapter_path(id: @chapter.id)

	end

end
