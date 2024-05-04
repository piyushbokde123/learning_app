class Tutor < ApplicationRecord
  belongs_to :course
  validates :email, presence: true, uniqueness: true
  validates :name, :about, :experience, :specialization, presence: true
end
