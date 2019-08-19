class Forum < ApplicationRecord
	belongs_to :course
	has_many :discussions 
	validates :title, presence: true,
                    length: { minimum: 5 }
end
