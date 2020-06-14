FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "emails#{n}@user" }
    password {"qwerty"}
    sequence(:name) { |n| "user#{n}" }
    trait :admin do
      admin { true }
    end
  end
end
