# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authentication do
    provider { ["facebook", "google", "linkedin"].shuffle.first }
    provider_id { SecureRandom.hex(6) }
    provider_token { SecureRandom.hex(6) }
    provider_token_expires_at { 45.days.from_now }
  end
end
