require 'rails_helper'

RSpec.describe CourseSerializer do
  let(:course) { FactoryBot.create(:course, tutors_attributes: [{ name: 'Carry',
              email: 'carry@example.com', about: 'Experienced tutor', experience: '5 years',
              specialization: 'Ruby'}]) }

  let(:serializer) { described_class.new(course) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer).to_json }
  let(:parsed_response) { JSON.parse(serialization) }

  describe 'attributes' do
    it 'includes the expected attributes' do
      expect(parsed_response.keys).to contain_exactly('id', 'title', 'description', 'duration', 'price', 'level', 'tutors')
    end

    it 'includes the correct values for each attribute' do
      expect(parsed_response['id']).to eq(course.id)
      expect(parsed_response['title']).to eq(course.title)
      expect(parsed_response['description']).to eq(course.description)
      expect(parsed_response['duration']).to eq(course.duration)
      expect(parsed_response['price']).to eq(course.price.to_s)
      expect(parsed_response['level']).to eq(course.level)
    end
  end

  describe 'associations' do
    it 'includes tutors' do
      expect(parsed_response['tutors']).to be_an(Array)
      expect(parsed_response['tutors'].size).to eq(course.tutors.count)
      
      parsed_response['tutors'].each_with_index do |tutor_hash, index|
        tutor = course.tutors[index]
        expect(tutor_hash['id']).to eq(tutor.id)
        expect(tutor_hash['name']).to eq(tutor.name)
        expect(tutor_hash['email']).to eq(tutor.email)
        expect(tutor_hash['about']).to eq(tutor.about)
        expect(tutor_hash['experience']).to eq(tutor.experience)
        expect(tutor_hash['specialization']).to eq(tutor.specialization)
      end
    end
  end
end
