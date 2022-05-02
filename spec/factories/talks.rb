FactoryBot.define do
  factory :talk do
    title { 'talk title' }
    association :user
  end
end
