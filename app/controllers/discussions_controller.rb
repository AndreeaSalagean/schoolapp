class DiscussionsController < ApplicationController
 	before_action :set_course, only: [:index, :new, :edit, :show]

  def index
  	@forum = Forum.find(params[:forum_id])
  	session[:forum_id] = @forum.id
  	@discussions = @forum.discussions
  end

  def show
  	@discussion = Discussion.find(params[:id])
  	session[:dis_id] = params[:id]
  	@replies = @discussion.replies
  	session[:course_id] = @course.id
	end

	def new
	end

  def edit
  	session[:dis_id] = params[:id]
  	session[:course_id] = @course.id
  end

  def create
  	@forum = Forum.find(session[:forum_id])
  	@discussion = Discussion.create(dis_params)
  	@discussion.started_by = current_user.email
  	@discussion.forum_id = @forum.id

  	unless @discussion.save
      flash[:error] = @discussion.errors.full_messages.first
      redirect_to action: 'new'
   	  return 
  	end

    redirect_to forum_discussions_path(forum_id: session[:forum_id], course_id: session[:course_id] )
  end

  def update
  	@discussion = Discussion.find(session[:dis_id])
   
	unless  @discussion.update(dis_params) 
		flash[:error] = @discussion.errors.full_messages.first
    render 'edit'
    return
  end
   
    redirect_to forum_discussions_path(forum_id: session[:forum_id], course_id: session[:course_id] )
  end

  private
    def set_course
  	 @course = Course.find(params[:course_id])
    end

    def dis_params   
      params.require(:discussion).permit(:title, :comment)   
    end
end
