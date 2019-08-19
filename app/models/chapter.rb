class Chapter < ApplicationRecord
	belongs_to :course
	has_many :assignments
	has_many :resources
	validates :title, presence: true,
                    length: { minimum: 5 }
end
