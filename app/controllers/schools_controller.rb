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
 
  def create
    
    @school = School.create(school_params)

    @user = User.new(user_params)
    @user.school_id = @school.id
    @user.role = 'admin'
    @user.password_confirmation = @password

    unless @user.save!
      redirect_to action: 'new' 
      return 
    end 

    redirect_to @school #controller
end
 
private
  def school_params
    params.require(:school).permit(:title, :id)
  end

  def search_school_params
    params.permit(:title, :id)
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :address, :telephone, :password_confirmation)
  end
end
