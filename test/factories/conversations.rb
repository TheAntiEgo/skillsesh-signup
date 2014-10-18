# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conversation do
    customer nil
    merchant nil
    course nil
  end
end
