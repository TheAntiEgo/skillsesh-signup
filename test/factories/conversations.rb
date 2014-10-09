# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conversation do
    subject {Faker::Lorem.sentence}
    body [Faker::Lorem.paragraph]
    customer
    merchant
    customer_read_at {DateTime.now}
    merchant_read_at nil
  end
end
