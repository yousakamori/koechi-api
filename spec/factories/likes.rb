FactoryBot.define do
  factory :like do
    liked { true }
    likable_type { 'Note' }
    association :likable, factory: :note
    association :user

    trait :not_liked do
      liked { false }
    end

    trait :for_comment do
      association :likable, factory: :comment
    end

    trait :for_talk do
      association :likable, factory: :talk
    end

    trait :for_note do
      association :likable, factory: :note
    end

    trait :for_user do
      association :likable, factory: :user
    end
  end
end
