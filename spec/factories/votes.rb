FactoryBot.define do
  factory :vote do
    association :user
    association :post
  end
end
