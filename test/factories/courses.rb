# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    name { Faker::Lorem.sentence }
    goal { Faker::Lorem.sentences(3).join(' ') }    
    how { Faker::Lorem.sentences(3).join(' ') }
    requirements { Faker::Lorem.sentences(3).join(' ') }
    duration 2
    price 23
  end
end
