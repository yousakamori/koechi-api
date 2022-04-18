FactoryBot.define do
  factory :user, aliases: [:owner] do
    name { 'taro' }
    sequence(:username) { |n| "taro#{n}" }
    sequence(:email) { |n| "test_you#{n}@example.com" }
    password { 'passw0rd' }
    bio { '' }
    activated_at { Time.current }

    trait :not_activated do
      name { nil }
      username { nil }
      activated_at { nil }
    end

    trait :with_token do
      activated_at { nil }
      activation_token { 'testtoken' }
      activation_token_expires_at { Time.current + 1.day }
    end

    trait :with_avatar do
      avatar do
        fixture_file_upload(Rails.root.join('spec/support/assets/test.png'))
      end
    end
  end
end
