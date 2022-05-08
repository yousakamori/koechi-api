FactoryBot.define do
  factory :notification do
    action { 'comment' }
    notifiable_type { 'Comment' }
    association :notifiable, factory: :comment
    association :sender, factory: :user
    association :recipient, factory: :user

    trait :for_comment do
      action { 'comment' }
      notifiable_type { 'Comment' }
      association :notifiable, factory: :comment
    end

    trait :for_member do
      action { 'invite' }
      notifiable_type { 'Membership' }
      association :notifiable, factory: :membership
    end

    trait :for_note do
      action { 'note' }
      notifiable_type { 'Note' }
      association :notifiable, factory: :note
    end

    trait :for_follow do
      action { 'follow' }
      notifiable_type { nil }
      notifiable_id { nil }
    end

    trait :for_talk do
      action { 'like' }
      notifiable_type { 'Talk' }
      association :notifiable, factory: :talk
    end

    # error
    trait :for_user do
      action { 'like' }
      notifiable_type { 'User' }
      association :notifiable, factory: :user
    end
  end
end
