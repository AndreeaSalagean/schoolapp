class RepliesController < ApplicationController
	def index
	end

	def new
	end

	def create
		@reply = Reply.create(reply_params)
		@reply.commenter = current_user.email
		@reply.discussion_id = session[:dis_id]
		unless @reply.save!
      flash[:error] = @reply.errors.full_messages.first
      redirect_to action: 'new'
   	  return 
  	end 
    
    redirect_to forum_discussion_path(forum_id: session[:forum_id], course_id: session[:course_id], id:session[:dis_id] )
	end

	private
		def reply_params   
  		params.require(:reply).permit(:body)   
  	end
end
