require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe 'GET #index' do
    context 'when there are courses with tutors' do
      let(:ruby_course_params) do
        {
          title: 'Ruby',
          description: 'Ruby course',
          duration: '3 months',
          price: 100,
          level: 'Intermediate',
          tutors_attributes: [
            {
              name: 'Carry',
              email: 'carry@example.com',
              about: 'Experienced tutor',
              experience: '5 years',
              specialization: 'Ruby'
            }
          ]
        }
      end

      before do
        FactoryBot.create(:course, ruby_course_params)
        get :index
      end

      it 'returns a list of courses with tutors' do
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response).to be_present
        expect(json_response.first['title']).to eq('Ruby')
        expect(json_response.first['description']).to eq('Ruby course')
        expect(json_response.first['tutors'].size).to be >= 1
      end
    end

    context 'when there are no courses' do
      it 'returns an empty list' do
        get :index
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response).to be_empty
      end
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          course: {
            title: 'Ruby',
            description: 'Ruby course',
            duration: '3 months',
            price: 100,
            level: 'Intermediate',
            tutors_attributes: [
              {
                name: 'John Doe',
                email: 'john@example.com',
                about: 'Experienced tutor',
                experience: '5 years',
                specialization: 'Ruby'
              }
            ]
          }
        }
      end

      it 'creates a new course with tutors' do
        expect do
          post :create, params: valid_params
        end.to change { Course.count }.by(1)
          .and change { Tutor.count }.by(1)

        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response['title']).to eq('Ruby')
        expect(json_response['description']).to eq('Ruby course')
        expect(json_response['tutors'].size).to be >= 1
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
