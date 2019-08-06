class CoursesController < ApplicationController

def index
   @courses = Course.where(school_id: current_user.school_id)
   @school = School.find(current_user.school_id)
   if current_user.role != 'student'
     @courses1 = UserCourse.where(teacher_id: current_user.id)
     @course_teacher = []
     @courses1.each do |user_course|
        @course_teacher << user_course.course
      end

     @courses_not = @courses - @course_teacher
     
     @course_own = UserCourse.find_by(teacher_id: current_user.id, owner: 1)
   else    
      @courses_student = current_user.courses
   end
   
end


def show
   @course = Course.find(params[:id])
   @school = School.find(current_user.school_id)
end

def show_course_enable
   @courses = Course.where(school_id: current_user.school_id)
   @courses_student = current_user.courses
   @courses2 = @courses - @courses_student
end

def new
 	  @course = Course.new
    @school = School.find(current_user.school_id)
end

def edit

  @school = School.find(current_user.school_id)
  @course = Course.find(params[:id])

end

def create_course
    
    @user = User.find_by(id: current_user.id)
    @course = Course.create(course_create_params)
    @course.school_id = @user.school_id

    UserCourse.create(course_id: @course.id, teacher_id: @user.id, owner: 1)

    unless @course.save
      flash[:error] = @course.errors.full_messages.first
      redirect_to action: 'new'
      return 
    end 

    redirect_to courses_path #controller

end

def update_course

    @course = Course.find(course_id_params[:course_id])
   
    if  @course.update(update_params) 
      redirect_to courses_path
    else
      redirect_to  edit_course_path 
    end
  end

def update_owner

    @course = Course.find(params[:course_id])
    @user = User.find_by(id: params[:user_id])
    user_course = UserCourse.find_by(course_id: @course.id, teacher_id: @user.id)
    user_course1 = UserCourse.find_by(course_id: @course.id, owner: 1)
    user_course1.update(owner: 0)
    user_course.update(owner: 1) 

    redirect_to show_teachers_courses_path(course_id: @course.id)
   
  end

def destroy

   @course = Course.find(params[:id])
   @course.destroy
 
   redirect_to courses_path
end

def enroll_student

  @course = Course.find(params[:course_id])
  @students_id = params[:send_text]
  
  @students_id.each do |student_id| 
      @student_course = StudentCourse.create(student_id: student_id, course_id: @course.id)
  end

  redirect_to courses_path
end

def add_student_course

  @course = Course.find(params[:course_id])
  @students_all = User.where(school_id: current_user.school_id, role: "student")
  @students = @students_all - @course.students
  

end


 def show_teachers

    @course = Course.find(params[:course_id])
    @users = @course.teachers
    @owner_id = UserCourse.find_by(course_id: @course.id, owner: 1).teacher_id

  end

def add_teacher
 
  @course = Course.find(params[:format])
  @user = User.find(current_user.id)
  @user_course = UserCourse.find_by(teacher_id: @user.id, course_id: @course.id)

  @user_course = UserCourse.create(course_id: @course.id, teacher_id: @user.id, owner: 0)
  unless @user_course.save! 
      redirect_to action: 'new' 
      return 
    end 
     redirect_to courses_path
end

def join_teachers
  @course = Course.find(params[:course_id])
  @teachers = @course.teachers
  @all_teachers = User.where(school_id: current_user.school_id, role: 'teacher')
  @main_teacher = @teachers.where(owner: 1)
  @teachers_not = @all_teachers - @teachers
end

def join_students

  @course = Course.find(params[:course_id])

end

def join_students_enroll
  @course = Course.find(params[:course_id])
  @key = params[:enrollement_key]
  if @course.enrollement_key == @key 
    @student_course = StudentCourse.create(student_id: current_user.id, course_id: @course.id)
  end
  redirect_to show_course_enable_courses_path
end

def join_teacher_course
  @course = Course.find(params[:course_id])
  @teachers_id = params[:send_text]
  
  @teachers_id.each do |teacher_id| 
      @teacher_course = UserCourse.create(teacher_id: teacher_id, course_id: @course.id, owner: 0)
  end

  redirect_to show_teachers_courses_path(course_id: @course.id)
end

def remove_from_course

  @course = Course.find(params[:id])
  @user = User.find(params[:user_id])
  
  @user_course = UserCourse.find_by(teacher_id: @user.id, course_id: @course.id)
  @user_course.destroy
 
  redirect_to show_teachers_courses_path(course_id: @course.id)
end


private
  def show_params
    params.require(:course).permit(:id)
  end
  def update_enroll_params
    params.require(:school).permit(:enrollement_key)
  end
  def update_params
    params.require(:course).permit(:title, :description, :enrollement_key)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end

  def course_create_params
    params.require(:course).permit(:title, :enrollement_key, :description)
  end

  def course_id_params
    params.permit(:course_id)
  end

  def set_school
  	@school = School.find(params[:school_id])
  end

end
