FactoryBot.define do
  factory :comment do
    body_text { 'あいうえお' }
    body_json { '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"あいうえお"}]}]}' }
    parent { nil }
    body_updated_at { nil }
    slug { '9c9be232234b36' }
    liked_count { 0 }
    commentable_type { 'Note' }
    association :commentable, factory: :note
    association :user

    trait :for_talk do
      association :commentable, factory: :talk
    end
  end
end
