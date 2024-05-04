class Course < ApplicationRecord
	has_many :tutors, dependent: :destroy
	validates :title, :description, :duration, :price, presence: true
	validates :tutors, presence: true
	validate :unique_tutor_emails
	
	enum level: { Beginner: 0, Intermediate: 1, Advanced: 2 }
	accepts_nested_attributes_for :tutors
  
  private

	def unique_tutor_emails
    return unless tutors.any? && tutors.map(&:email).uniq.size != tutors.size

    errors.add(:base, 'Each course must have tutors with unique email addresses')
  end
end
