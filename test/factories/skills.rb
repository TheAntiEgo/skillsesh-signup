# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill do
    sequence :name do |n|
      Faker::Lorem.word + n.to_s    
    end
  end
end
