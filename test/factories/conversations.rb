# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conversation do
    association :customer, :factory => :user, :strategy => :build
    association :merchant, :factory => :user, :strategy => :build
    
    factory :active_conversation do
      ignore do
        count 1
      end
      
      after(:build) do |convo, evaluator|
        if evaluator.count == 1
          convo.messages = build_list(:message, 1, :sender => convo.customer, :recepient => convo.merchant)
        else
          1.upto(evaluator.count) do |i|
            convo.messages << build(:message, :sender => i.odd? ? convo.customer : convo.merchant , :recepient => i.odd? ? convo.merchant : convo.customer , :read => i < evaluator.count ? true : false, :read_at => i.days.from_now.to_datetime)          
          end
        end
        
        convo.course = build(:course, :instructor => convo.merchant)
      end
    end
    
    factory :initial_conversation do
      association :course, :factory => :course, :instructor => merchant
    end
  end
end
