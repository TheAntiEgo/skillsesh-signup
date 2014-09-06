# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    remember_token { SecureRandom.uuid }
    
    after :build do |user|
      user.authentications << build(:authentication)
    end
  end
end