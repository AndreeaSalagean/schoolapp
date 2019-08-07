class Chapter < ApplicationRecord
	belongs_to :course
	has_many :assignments
	validates :title, presence: true,
                    length: { minimum: 5 }
end
