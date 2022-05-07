FactoryBot.define do
  factory :comment do
    body_text { 'comment body' }
    body_json { '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"comment body"}]}]}' }
    parent { nil }
    body_updated_at { nil }
    slug { SecureRandom.hex(7) }
    liked_count { 0 }
    commentable_type { 'Note' }
    association :commentable, factory: :note
    association :user

    trait :for_note do
      commentable_type { 'Note' }
      association :commentable, factory: :note
    end

    trait :for_talk do
      commentable_type { 'Talk' }
      association :commentable, factory: :talk
    end

    trait :for_like do
      commentable_type { 'Like' }
      association :commentable, factory: :like
    end
  end
end
