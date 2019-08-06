class Course < ApplicationRecord
	has_many :user_courses, dependent: :destroy
	has_many :teachers, class_name: 'User', foreign_key: 'teacher_id', through: :user_courses

	has_many :student_courses
	has_many :students, class_name: 'User', foreign_key: 'student_id', through: :student_courses

	has_many :chapters
    validates :title, presence: true,
                    length: { minimum: 5 }
    
end
