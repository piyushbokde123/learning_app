class CourseSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :duration, :price, :level
  has_many :tutors

  def tutors
    object.tutors.map do |tutor|
      {
        id: tutor.id,
        name: tutor.name,
        email: tutor.email,
        about: tutor.about,
        experience: tutor.experience,
        specialization: tutor.specialization
      }
    end
  end
end