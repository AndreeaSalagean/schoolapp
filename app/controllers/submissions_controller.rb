class SubmissionsController < ApplicationController
  before_action :set_assignment, only: [:new]

  # GET /submissions submission_path 
  # GET /submissions.json
  def index
    @submissions = Submission.all
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
    @array = [1,2,3,4,5,6,7,8,9,10]
    @submission = Submission.find(params[:id])

  end

  # GET /submissions/new
  def new
    @course = Course.find(params[:course_id])
    @chapter = Chapter.find(params[:chapter_id])
    @submission = Submission.new

    session[:course_id] = @course.id
    session[:chapter_id] = @chapter.id
    session[:assig_id] = @assignment.id
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @assignment = Assignment.find(session[:assig_id])
    @student = User.find(current_user.id)
    @submission = Submission.create(submission_params)
    @submission.student_id = @student.id
    @submission.assignment_id = @assignment.id
    @submission.submit = true

    respond_to do |format|
      if @submission.save
        format.html { redirect_to course_chapter_assignment_path(course_id: session[:course_id], chapter_id: session[:chapter_id], id: session[:assig_id] ), notice: 'Submission was successfully created.' }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end


  def grade
    @sub = Submission.find(params[:sub_id])
    @sub.update(grade: params[:send_text])
    unless @sub.save
      flash[:error] = @sub.errors.full_messages.first
      redirect_to action: 'grade'
      return
    end   
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      params.require(:submission).permit(:new, :content)
    end

    def set_assignment
     @assignment = Assignment.find(params[:assig_id])
    end
end
