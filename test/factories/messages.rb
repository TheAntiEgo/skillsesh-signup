# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    sender nil
    receiver nil
    content "MyText"
    read_at "2014-10-18 01:59:05"
  end
end
