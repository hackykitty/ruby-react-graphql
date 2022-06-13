FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Jane Doe ##{ n }" }
    sequence(:email) { |n| "jane.doe.#{ n }@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
