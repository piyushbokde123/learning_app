FactoryBot.define do
  factory :course do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    duration { "#{Faker::Number.between(from: 1, to: 12)} months" }
    price { Faker::Number.between(from: 10, to: 1000) }
    level { Course.levels.keys.sample }
    
    transient do
      tutors_count { 1 } 
    end

    after(:create) do |course, evaluator|
      course.tutors << FactoryBot.create_list(:tutor, evaluator.tutors_count, course: course)
    end
  end
end
