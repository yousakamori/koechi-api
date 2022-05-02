FactoryBot.define do
  factory :membership do
    association :user
    association :space
  end
end
