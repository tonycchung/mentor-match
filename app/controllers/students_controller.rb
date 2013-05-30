class StudentsController < ApplicationController
	before_filter :authorize_admin!, except: [:new, :create, :thanks]

	def index
		#need to change this
		@studentnomentors = Student.where("mentor_id is NULL")
		@studentsall  = Student.all
		@mentornostudents = Mentor.find(
																	:all,
																	:joins => "LEFT OUTER JOIN 'students' ON students.mentor_id = mentors.id
																				WHERE students.mentor_id is NULL")
		@mentorsall = Mentor.all
	end

	def show
		@student = Student.find(params[:id])
	end

	def edit
		@student = Student.find(params[:id])
	end

	def new
		@student = Student.new
	end

	def create
		@student = Student.new(params[:student])
		if @student.save
			redirect_to '/thanks'
		else
			#change flash message if email is not unique
			flash[:alert] = 'Sorry, there was a problem. ' +
											'Please make sure your first name, last name, & email are all filled in.'
			render :action => "new"
		end
	end

	def thanks
	end

	def pair
		@mentors = Mentor.all
		@students = Student.all
    @mentornostudents = Mentor.find(
                                  :all,
                                  :joins => "LEFT OUTER JOIN 'students' ON students.mentor_id = mentors.id
                                        WHERE students.mentor_id is NULL")
	end

	def update
		@student = Student.find(params[:id])
		past_mentor_id = @student.mentor.try(:id)

		if @student.update_attributes(params[:student])
			if @student.mentor_id
				unless past_mentor_id == @student.mentor_id
					flash[:notice] = @student.personal_first_name + ' ' + @student.personal_last_name + ' had been paired with ' + @student.mentor.personal_first_name + ' ' + @student.mentor.personal_last_name				end
			else
				flash[:notice] = @student.personal_first_name + ' ' + @student.personal_last_name + ' has been edited.'
			end
			redirect_to student_path(@student)
		else
			flash[:notice] = 	'There was a problem!' +
												'Please make sure your first name, last name, & email are all filled in.'
			render :action => "edit"
		end
	end

	def destroy
		@student = Student.find(params[:id])
		firstname = @student.personal_first_name
		lastname = @student.personal_last_name
		@student.destroy
		redirect_to students_path, :notice => "#{firstname} #{lastname} has been removed from the database."
	end

	private

	def authorize_admin!
		authenticate_user!
		unless current_user.admin?
			flash[:alert] = "You must be an admin to do that!"
			redirect_to root_path
		end
	end
end
