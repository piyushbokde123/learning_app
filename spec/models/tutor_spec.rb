require 'rails_helper'

RSpec.describe Tutor, type: :model do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:about) }
      it { should validate_presence_of(:experience) }
      it { should validate_presence_of(:specialization) }
    end

    context 'uniqueness of email' do
      subject { FactoryBot.build(:tutor) }

      it 'is not valid with a duplicate email' do
        duplicate_tutor = subject.dup
        expect(duplicate_tutor).not_to be_valid
      end
    end
  end

  describe 'associations' do
    context 'belongs to course' do
      it { should belong_to(:course) }
    end
  end
end
