class Course < ApplicationRecord
	has_many :tutors, dependent: :destroy
	validates :title, :description, :duration, :price, presence: true
	validates :tutors, presence: true
	enum level: { Beginner: 0, Intermediate: 1, Advanced: 2 }
	accepts_nested_attributes_for :tutors 
end
