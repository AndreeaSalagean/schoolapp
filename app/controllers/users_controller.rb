class UsersController < ApplicationController
  before_action :set_school, only: [:show, :index]

  def index
   # @users = User.all
   # @school = School.find user_params[:school_id]
   # @user = User.all.select { |user| user.school_id == school.id }#user_params[:school_id] }
   @users = User.where(school_id: @school.id)
  end

  def show
    @users = User.where(school_id: current_user.school_id)
  end
  
  def show_students
    @users = User.where(school_id: current_user.school_id, role: 'student')
  end

  def new
  	@user = User.new
  end


  def edit
    @user = User.find(params[:id])
  end

  def create_user

    @user = User.new(user_params_create)
    @user.school_id = current_user.school_id
    @user.password_confirmation = @password
    
    if params[:send_text] 
      @user.role = 'teacher'
    else
      @user.role = 'student'
    end
    unless @user.save!
      flash[:error] = @user.errors.full_messages.first
      redirect_to action: 'new' 
      return 
    end 

    redirect_to users_path(school_id: current_user.school_id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path(school_id: user_params[:school_id])
    else
      redirect_to action: 'edit'
    end
  end

 def destroy
  @user = User.find(params[:id])
  @user.destroy

  redirect_to users_path(school_id: school_params[:school_id])
end

private
  def role_params

    params.require(:user).permit(:send_text)
  end
  def user_params
    params.require(:user).permit(:id,:email,:password, :role, :school_id)
  end

  def user_params_create
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end

  def school_params
    params.permit(:school_id)
  end

  def set_school 
    @school = School.find(current_user.school_id)
  end
end
