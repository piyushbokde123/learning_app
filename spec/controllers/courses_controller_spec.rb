require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new course with tutors' do
        expect do
          post :create, params: { course: { title: 'Ruby', description: 'Ruby course', 
            duration: '3 months', price: 100, level: 'Intermediate', tutors_attributes: 
            [{ name: 'John Doe', email: 'john@example.com', about: 'Experienced tutor', 
              experience: '5 years', specialization: 'Ruby' }] } }
        end.to change { Course.count }.by(1)
            .and change { Tutor.count }.by(1)
        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response['title']).to eq('Ruby')
        expect(json_response['tutors'].size).to eq(1)
      end
    end

    context 'when course creation fails' do
      it 'returns unprocessable entity if course creation fails' do
        post :create, params: { course: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when tutors are invalid' do
      it 'returns unprocessable entity if tutors are invalid' do
        post :create, params: { course: { title: 'Ruby', description: 'Ruby course', 
          duration: '3 months', price: 100, level: 'Beginner', tutors_attributes: 
          [{ name: 'Vinsh', email: '', about: 'Experienced tutor', experience: '5 years', 
            specialization: 'Ruby' }] } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when tutors are duplicated' do
      it 'returns unprocessable entity if tutors are duplicated' do
        post :create, params: { course: { title: 'Ruby', description: 'Ruby course', 
          duration: '3 months', price: 100, level: 'Advanced', tutors_attributes: 
          [{ name: 'Ablo', email: '', about: 'Experienced tutor', experience: '5 years', 
            specialization: 'Ruby' }, { name: 'Ablo', email: '', about: 'Experienced tutor',
             experience: '5 years', specialization: 'Ruby' }] } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when no tutors are provided' do
      it 'returns unprocessable entity if no tutors are provided' do
        post :create, params: { course: { title: 'Ruby', description: 'Ruby course', 
          duration: '3 months', price: 100, level: 'Advanced' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
