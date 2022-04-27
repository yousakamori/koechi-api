FactoryBot.define do
  factory :space do
    name { 'space title' }
    emoji { '🦁' }
    association :owner

    trait :with_memberships do
      after(:create) do |space|
        create(:membership, space: space, user: space.owner)
        create_list(:membership, 2, space: space)
      end
    end
  end
end
