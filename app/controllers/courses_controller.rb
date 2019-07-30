class CoursesController < ApplicationController

def index
  


  if current_user.role == 'student'
    # @courses = Course.where(id: StudentCourse.find_by(student_id: current_user.id).course_id )
    @courses = current_user.courses
  else

    @courses = Course.where(school_id: current_user.school_id)
 
  end
end

def new
 	 @course = Course.new
end

def edit
	 @course = Course.find(params[:id])
end

def create_course
    

    @user = User.find_by(first_name: user_params[:first_name], last_name: user_params[:last_name])
    
    if current_user.role == 'admin'
        unless @user != nil && @user.role = 'teacher' && @user.school_id == current_user.school_id
          redirect_to action: 'new' 
          return 
        end 

    else
      unless @user.first_name = current_user.first_name && @user.last_name = current_user.last_name
        redirect_to action: 'new' 
          return 
      end 
    end


    @course = Course.create(course_create_params)
    @course.school_id = current_user.school_id

    UserCourse.create(course_id: @course.id, teacher_id: @user.id, owner: 1)


    unless @course.save! 
      redirect_to action: 'new' 
      return 
    end 

    redirect_to courses_path #controller

end

def update_course

    @course = Course.find(course_id_params[:course_id])
    @user = User.find_by(id: update_params[:id])
    @user_course = UserCourse.find_by(course_id: @course.id, teacher_id: @user.id)
    
    unless @user_course != nil && @user_course.owner = 0
       redirect_to  edit_course_path 
            return 
          end 
    if current_user.role == 'admin'
      @user_course1 = UserCourse.find_by(course_id: @course.id, owner: 1)
      @user_course1.update(:owner => 0)
      @user_course.owner = 1

    else if current_user.role == 'teacher'
      @user_course1 = UserCourse.find_by(course_id: @course.id, owner: 1)

      unless @user_course1.teacher_id == current_user.id 
         redirect_to edit_course_path
            return 
          end 
     
      @user_course1.update(:owner => 0)
      @user_course.update(:owner => 1)
    
   end
 end
   
    if  @user_course.update(update_params) 
      redirect_to courses_path
    else
      redirect_to  edit_course_path 
    end
  end


def destroy
   @course = Course.find(params[:id])
   @course.destroy
 
   redirect_to courses_path
end

def edit_teacher_course
end

def add_student_course
end

def add_student

   @course = Course.where(title: course_create_params[:title]).first
   @user = User.find_by(first_name: user_params[:first_name], last_name: user_params[:last_name])
   
    unless @user != nil && @user.role = 'student' && @user.school_id == current_user.school_id 
       redirect_to add_student_course_courses_path 
              return 
    end 

  
  if current_user.role == 'teacher'

    @user_course = UserCourse.find_by(teacher_id: current_user.id, course_id: @course.id)
 

    unless @user_course != nil && @user_course.owner = 1
      redirect_to add_student_course_courses_path
       return
    end

  end

  @student_course = StudentCourse.find_by(course_id: @course.id, student_id: @user.id)

  unless @student_course = nil
    redirect_to add_student_course_courses_path
              return 
    end 


  @student_course = StudentCourse.create(course_id: @course.id, student_id: @user.id)
  unless @student_course.save! 
      redirect_to add_student_course_courses_path 
      return 
    end 
     redirect_to courses_path


end

def add_teacher

  @course = Course.find_by(title: course_create_params[:title])
  @user = User.find_by(user_params)
  @user_course = UserCourse.find_by(teacher_id: current_user.id, course_id: @course.id)

  unless @user_course != nil && @user_course.owner = 0
       redirect_to action: 'update_course' 
            return 
          end 

  unless @user != nil && @course != nil
          redirect_to action: 'new' 
          return 
    end

  unless UserCourse.find_by(course_id: @course.id, teacher_id: @user.id) == nil
    redirect_to action: 'new' 
    return 
  end

  @user_course = UserCourse.create(course_id: @course.id, teacher_id: @user.id, owner: 0)
  unless @user_course.save! 
      redirect_to action: 'new' 
      return 
    end 
     redirect_to courses_path
end

private
  def update_params
    params.require(:user).permit(:id)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end

  def course_create_params
    params.require(:course).permit(:title)
  end

  def course_id_params
    params.permit(:course_id)
  end

  def set_school
  	@school = School.find(params[:school_id])
  end

end
