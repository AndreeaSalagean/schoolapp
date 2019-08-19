class ForumsController < ApplicationController
	before_action :set_course, only: [:new, :index, :edit]
	
	def index
		@forums = Forum.where(course_id: @course.id)
	end

	def new
		session[:course_id] = @course.id
	end

	def show
	end

	def edit
		session[:forum_id] = params[:id]
		session[:course_id] = @course.id
	end

	def create
		
		@forum = Forum.create(forum_params)
  	@forum.course_id = session[:course_id] 
  	unless @forum.save
      flash[:error] = @forum.errors.full_messages.first
      redirect_to action: 'new'
   	  return 
  	end 

    redirect_to forums_path(course_id: session[:course_id] )
	end

	def update
		@forum = Forum.find(session[:forum_id])
   
		unless  @forum.update(forum_params) 
				flash[:error] = @forum.errors.full_messages.first
    	  render 'edit'
    	return
    end
   
    redirect_to forums_path(course_id: session[:course_id])
	end

	private
    def forum_params   
      params.require(:forum).permit(:title, :description)   
    end

    def set_course
      @course = Course.find(params[:course_id])
    end
  end
