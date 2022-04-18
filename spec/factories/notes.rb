FactoryBot.define do
  factory :note do
    title { 'note title' }
    body_text { 'body_text' }
    body_json { 'body_json' }
    association :user
    association :space

    trait :with_comments do
      after(:create) { |note| create_list(:comment, 5, note: note) }
    end
  end
end
