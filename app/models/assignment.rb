class Assignment < ApplicationRecord
	belongs_to :chapter
	has_many :submissions
	validates :title, presence: true,
                    length: { minimum: 5 }
end
