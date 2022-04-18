FactoryBot.define do
  factory :talk do
    title { 'title' }
    association :user
  end
end
