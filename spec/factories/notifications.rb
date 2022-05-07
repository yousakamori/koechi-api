FactoryBot.define do
  factory :notification do
    action { 'comment' }
    notifiable_type { 'Comment' }
    association :notifiable, factory: :comment
    association :sender, factory: :user
    association :recipient, factory: :user
  end
end
