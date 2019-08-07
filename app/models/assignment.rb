class Assignment < ApplicationRecord
	belongs_to :chapter
	validates :title, presence: true,
                    length: { minimum: 5 }
end
