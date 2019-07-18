class UsersController < ApplicationController
  def index
   # @users = User.all
   # @school = School.find user_params[:school_id]
   # @user = User.all.select { |user| user.school_id == school.id }#user_params[:school_id] }
   @users = User.where(school_id: params[:school_id])
  end

  def show
    @user = User.find_by(params[:school_id])
  end
  
  def new
  	@user = User.new
  end


  def edit
    @user = User.find(params[:id])
  end

  def create_user
    puts "-----------"
    @user = User.new(user_params_create)
    @user.school_id = params[:school_id]
    @user.password_confirmation = @password

    unless @user.save!
      redirect_to action: 'new' 
      return 
    end 

    redirect_to users_path(school_id: params[:school_id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path(school_id: user_params[:school_id])
    else
      redirect_to action: 'edit'
    end
  end

private
  def user_params
    params.require(:user).permit(:id,:email,:password, :role, :school_id)
  end

  def user_params_create
    params.require(:user).permit(:email, :password, :role)
  end
end
