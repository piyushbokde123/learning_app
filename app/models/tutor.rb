class Tutor < ApplicationRecord
  belongs_to :course
  validates :name, :email, :about, :experience, :specialization, presence: true
end
