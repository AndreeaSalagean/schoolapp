class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  belongs_to :school
  
  has_many :user_courses
  has_many :courses, through: :user_courses 

  has_many :student_courses, foreign_key: 'student_id'
  has_many :courses, through: :student_courses
end
