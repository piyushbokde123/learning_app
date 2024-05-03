FactoryBot.define do
  factory :course do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    duration { "#{Faker::Number.between(from: 1, to: 12)} months" }
    price { Faker::Number.between(from: 10, to: 1000) }
    level { Course.levels.keys.sample }

    after(:create) do |course|
      course.tutors << FactoryBot.create_list(:tutor, course: course)
    end
  end
end
