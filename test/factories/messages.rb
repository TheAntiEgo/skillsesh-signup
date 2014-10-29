# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    content { Faker::Lorem.sentences.join(' ') }
    
    factory :unread_message do
      sender
      recepient
    end
  end
end
