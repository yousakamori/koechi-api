FactoryBot.define do
  factory :notification do
    notifiable { nil }
    action { 'MyString' }
    user_id { 1 }
    sender_id { 1 }
  end
end
