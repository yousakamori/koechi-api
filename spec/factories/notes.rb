FactoryBot.define do
  factory :note do
    title { 'note title' }
    body_text { 'body_text' }
    body_json { 'body_json' }
    slug { SecureRandom.hex(7) }
    posted_at { Time.current }
    association :user
    association :space

    trait :with_comments do
      after(:create) { |note| create_list(:comment, 5, note: note) }
    end

    trait :initial_note do
      title { '' }
      body_text { nil }
      body_json { nil }
    end
  end
end
