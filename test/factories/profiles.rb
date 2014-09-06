# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    user
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    bio { Faker::Lorem.characters(150..500) }
    photo { "http://api.randomuser.me/portraits/" + %w{ men women}.shuffle.first + '/' + (0...95).last(94).shuffle.first.to_s + '.jpg' }
    
    after(:build) do |prof|
      prof.skills << build_list(:skill, Random.new.rand(1..5))
    end      
  end
end
