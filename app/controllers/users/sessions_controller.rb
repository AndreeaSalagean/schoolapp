# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
     super
  end

  # POST /resource/sign_in
  def create
    @school = School.find user_params[:school_id]
    @user = User.where(email: user_params[:email]).first
    if @user != nil
      if !(@user.school_id == @school.id)
        flash[:notice] = "#{ @user.id } do not have portal access."
        redirect_to user_session_path(school_id: user_params[:school_id])
      else
        super
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def after_sign_in_path_for(resource)
      session[:school_id] = current_user.school_id 
      school_path(id: session[:school_id])
  end
  
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private

  def school_params
    params.require(:school).permit(:id ,:school_id, :title)
  end

  def user_params
    params.require(:user).permit(:id,:email,:school_id, :role)
  end
end
