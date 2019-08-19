class SchoolsController < ApplicationController
	def login 
  end

  def index
  end

  def search_school
    @school = School.search(search_school_params[:title])
    if @school
       redirect_to user_session_path(school_id: @school.id)
    else
      render :index
    end
  end

	def show
    @school = School.find(params[:id])
  end

	def new
  end

  def edit
    @school = School.find(params[:id])
  end
 
  def create  
    @school = School.create(school_params)
    @school.enable_enroll = 0

    unless @school.save
      flash[:error] = @school.errors.full_messages.first
      redirect_to action: 'new'
      return
    end

    @user = User.new(user_params)
    @user.school_id = @school.id
    @user.role = 'admin'
    @user.password_confirmation = @password

    unless @user.save
      flash[:error] = @user.errors.full_messages.first
      redirect_to action: 'new' 
      return 
    end 
    
    sign_in(@user)
    redirect_to school_path(id: @school.id)
 end
 
 def update
  @school = School.find(params[:id])
  if enroll_params == true
    @school.enable_enroll = true
  else
    @school.enable_enroll = false
  end
  
  if @school.update(school_params)
    redirect_to @school
  else
    render 'edit'
  end
 end 


private
  def enroll_params
    params.require(:school).permit(:send_text)
  end

  def school_params
    params.require(:school).permit(:title, :id, :description, :address, :telephone)
  end

  def search_school_params
    params.permit(:title, :id)
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :address, :telephone, :password_confirmation)
  end
end
