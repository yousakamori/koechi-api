FactoryBot.define do
  factory :comment do
    body { 'comment body' }
    association :note
    association :user
  end
end
