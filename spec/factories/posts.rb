FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Awesome Idea ##{ n }" }
    sequence(:tagline) { |n| "The awesome idea ##{ n }" }
    sequence(:url) { |n| "https://example.com/#{ n }" }
    association :user
  end
end
