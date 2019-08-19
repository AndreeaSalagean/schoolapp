class Submission < ApplicationRecord
	has_rich_text :content
	belongs_to :student, class_name: 'User', foreign_key: 'student_id' 
	belongs_to :assignment
end
