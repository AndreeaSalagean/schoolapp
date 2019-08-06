class School < ApplicationRecord
	has_many :users, dependent: :destroy


	 validates :telephone,   :presence => {:message => 'hello world, bad operation!'},
                     :numericality => true,
                     :length => { :minimum => 10, :maximum => 15 }
    validates :title, presence: true,
                    length: { minimum: 5 }
          
	

	def self.search(search)
	  school=School.find_by(title: search)
	end

    
end
