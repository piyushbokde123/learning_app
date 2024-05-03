require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:description) }
      it { should validate_presence_of(:duration) }
      it { should validate_presence_of(:price) }
      it { should validate_presence_of(:tutors) }
    end
  end

  describe 'associations' do
    context 'has many tutors' do
      it { should have_many(:tutors).dependent(:destroy) }
    end
  end

  describe 'enums' do
    context 'level' do
      it { should define_enum_for(:level).with_values({ Beginner: 0, Intermediate: 1, Advanced: 2 }) }
    end
  end

  describe 'nested attributes' do
    context 'accepts nested attributes for tutors' do
      it { should accept_nested_attributes_for(:tutors) }
    end
  end
end
