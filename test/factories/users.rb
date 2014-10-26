# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, :aliases => [:instructor, :sender, :recepient, :merchant, :customer] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { "#{first_name}.#{last_name}@testing.com" }
    bio { Faker::Lorem.sentences.join(' ') }
    remember_token { SecureRandom.uuid }    
    photo { "http://api.randomuser.me/portraits/" + %w{ men/ women/ }.shuffle.first + Random.new.rand(1..80).to_s + ".jpg" }
  end
end
