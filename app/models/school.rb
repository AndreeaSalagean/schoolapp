class School < ApplicationRecord
	has_many :users

	def self.search(search)
	  school=School.find_by(title: search)

	end
end
