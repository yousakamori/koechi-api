require 'rails_helper'

RSpec.describe Notification, type: :model do
  it 'actionが有効なこと' do
    notification = build(:notification, :for_comment, action: :like)
    expect(notification).to be_valid

    notification = build(:notification, :for_comment, action: :comment)
    expect(notification).to be_valid

    notification = build(:notification, :for_comment, action: :comment_reply)
    expect(notification).to be_valid
  end

  it 'actionが無効なこと' do
    notification = build(:notification, :for_comment, action: :error)
    notification.valid?

    expect(notification.errors[:action]).to include('は一覧にありません')
  end

  it 'notifiable_typeが有効なこと' do
    notification = build(:notification, :for_comment)
    expect(notification).to be_valid

    notification = build(:notification, :for_member)
    expect(notification).to be_valid

    notification = build(:notification, :for_note)
    expect(notification).to be_valid

    notification = build(:notification, :for_follow)
    expect(notification).to be_valid

    notification = build(:notification, :for_talk)
    expect(notification).to be_valid
  end

  it 'notifiable_typeが無効なこと' do
    notification = build(:notification, :for_user)
    notification.valid?

    expect(notification.errors[:notifiable_type]).to include('は一覧にありません')
  end
end
