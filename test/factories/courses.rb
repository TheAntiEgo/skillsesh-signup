# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    name { Faker::Lorem.sentence }
    goal { Faker::Lorem.paragraph }
    how { Faker::Lorem.paragraph }
    requirements { Faker::Lorem.sentences(3).join(" ") }
    duration 1.0
    price 20.00
    location 3
  end
end