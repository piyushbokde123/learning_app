FactoryBot.define do
  factory :tutor do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    about { Faker::Lorem.paragraph }
    experience { Faker::Number.between(from: 1, to: 10) }
    specialization { Faker::Lorem.word }
    association :course
  end
end
