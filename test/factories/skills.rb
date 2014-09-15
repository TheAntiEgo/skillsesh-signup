# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:name) { |n| "#{Faker::Lorem.word}-#{n}" }
  
  factory :skill do
    name
  end
end
