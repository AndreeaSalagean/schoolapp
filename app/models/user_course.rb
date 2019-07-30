class UserCourse < ApplicationRecord
	belongs_to :course
	belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'
end
