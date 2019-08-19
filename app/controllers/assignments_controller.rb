class AssignmentsController < ApplicationController\

	def index
		@course = Course.find(params[:course_id])
		@assignments = @course.assignments
	end


	def show
		@course = Course.find(params[:course_id])
   	@assignment = Assignment.find(params[:id])
   	@submis = Submission.where(assignment_id: @assignment.id, grade: nil)
   	@chapter = Chapter.find(params[:chapter_id])
   	if current_user.role == 'student'
   		@submissions = @assignment.submissions
   		@submission  = nil
   		@submissions.each do |sub|
   		if sub.student_id == current_user.id
   				@submission = sub
   		end
   		end
  	end
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

		unless @assignment.save
    	flash[:error] = @assignment.errors.full_messages.first
      redirect_to action: 'new'
      return
   	end

		redirect_to course_chapter_path(id: @chapter.id)
	end
end
