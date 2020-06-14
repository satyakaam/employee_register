FactoryBot.define do
  factory :event do
    event_type { :check_in }
    occurred_at { Time.current }
    auto_generated { false }
    association :user

    trait :check_in do
      event_type { :check_in }
    end

    trait :check_out do
      event_type { :check_out }
    end
  end
end
