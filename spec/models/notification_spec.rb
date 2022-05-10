require 'rails_helper'

RSpec.describe Notification, type: :model do
  ActiveJob::Base.queue_adapter = :test
  let(:user) { create(:user) }
  let(:talk) { create(:talk) }

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

  it 'checkedがfalseのときはメールが送信されないこと' do
    create(:notification, notifiable: talk, checked: false, recipient_id: talk.user_id, sender_id: user.id, action: :like)

    expect do
      described_class.to_recipient!(action: :like, recipient: talk.user, sender: user, notifiable: talk)
    end.to have_enqueued_job(ActionMailer::MailDeliveryJob)
  end

  it 'checkedがtrueのときはメールが送信されないこと' do
    create(:notification, notifiable: talk, checked: true, recipient_id: talk.user_id, sender_id: user.id, action: :like)

    expect do
      described_class.to_recipient!(action: :like, recipient: talk.user, sender: user, notifiable: talk)
    end.not_to have_enqueued_job(ActionMailer::MailDeliveryJob)
  end
end
