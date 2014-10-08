# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conversation do
    subject "MyString"
    customer nil
    merchant nil
    body "MyText"
    customer_read_at "2014-10-08 04:21:33"
    merchant_read_at "2014-10-08 04:21:33"
  end
end
