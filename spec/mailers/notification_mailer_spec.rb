require 'rails_helper'

RSpec.describe NotificationMailer, type: :mailer do
  describe 'comment' do
    let(:recipient) { create(:user) }
    let(:sender) { create(:user) }
    let(:comment) { create(:comment) }
    let(:mail) { described_class.comment(recipient, sender, comment) }

    it '送信先がrecipientのメールアドレスであること' do
      expect(mail.to).to eq [recipient.email]
    end

    it '正しい送信元であること' do
      expect(mail.from).to eq ['noreply@koechi.com']
    end

    it '正しい件名であること' do
      expect(mail.subject).to eq 'コメントがつきました'
    end

    it '本文にsender nameが含まれていること' do
      expect(mail.html_part.body.raw_source).to include(sender.name)
      expect(mail.text_part.body.raw_source).to include(sender.name)
    end

    it '本文にsender usernameが含まれていること' do
      expect(mail.html_part.body.raw_source).to include(sender.username)
      expect(mail.text_part.body.raw_source).to include(sender.username)
    end

    it '本文にtitleが含まれていること' do
      expect(mail.html_part.body.raw_source).to include('note title')
      expect(mail.text_part.body.raw_source).to include('note title')
    end

    it '本文にlinkが含まれていること' do
      expect(mail.html_part.body.raw_source).to match(%r{#{Rails.configuration.x.app.client_url}/link/notes/\w{14}})
    end
  end

  describe 'comment_reply' do
    let(:recipient) { create(:user) }
    let(:sender) { create(:user) }
    let(:comment) { create(:comment) }
    let(:mail) { described_class.comment_reply(recipient, sender, comment) }

    it '送信先がrecipientのメールアドレスであること' do
      expect(mail.to).to eq [recipient.email]
    end

    it '正しい送信元であること' do
      expect(mail.from).to eq ['noreply@koechi.com']
    end

    it '正しい件名であること' do
      expect(mail.subject).to eq 'コメントに返信がつきました'
    end

    it '本文にsender nameが含まれていること' do
      expect(mail.html_part.body.raw_source).to include(sender.name)
      expect(mail.text_part.body.raw_source).to include(sender.name)
    end

    it '本文にsender usernameが含まれていること' do
      expect(mail.html_part.body.raw_source).to include(sender.username)
      expect(mail.text_part.body.raw_source).to include(sender.username)
    end

    it '本文にlinkが含まれていること' do
      expect(mail.html_part.body.raw_source).to match(%r{#{Rails.configuration.x.app.client_url}/link/comments/\w{14}})
    end
  end

  describe 'follow' do
    let(:recipient) { create(:user) }
    let(:sender) { create(:user) }
    let(:comment) { create(:comment) }
    let(:mail) { described_class.follow(recipient, sender, comment) }

    it '送信先がrecipientのメールアドレスであること' do
      expect(mail.to).to eq [recipient.email]
    end

    it '正しい送信元であること' do
      expect(mail.from).to eq ['noreply@koechi.com']
    end

    it '正しい件名であること' do
      expect(mail.subject).to eq "#{recipient.name}さんにフォローされました"
    end

    it '本文にsender nameが含まれていること' do
      expect(mail.html_part.body.raw_source).to include(sender.name)
      expect(mail.text_part.body.raw_source).to include(sender.name)
    end

    it '本文にsender usernameが含まれていること' do
      expect(mail.html_part.body.raw_source).to include(sender.username)
      expect(mail.text_part.body.raw_source).to include(sender.username)
    end

    it '本文にlinkが含まれていること' do
      expect(mail.html_part.body.raw_source).to include("#{Rails.configuration.x.app.client_url}/#{sender.username}")
    end
  end

  describe 'like' do
    let(:recipient) { create(:user) }
    let(:sender) { create(:user) }
    let(:comment) { create(:comment) }
    let(:mail) { described_class.like(recipient, sender, comment) }

    it '送信先がrecipientのメールアドレスであること' do
      expect(mail.to).to eq [recipient.email]
    end

    it '正しい送信元であること' do
      expect(mail.from).to eq ['noreply@koechi.com']
    end

    it '正しい件名であること' do
      expect(mail.subject).to eq 'あなたのコメントがいいねされました'
    end

    it '本文にsender nameが含まれていること' do
      expect(mail.html_part.body.raw_source).to include(sender.name)
      expect(mail.text_part.body.raw_source).to include(sender.name)
    end

    it '本文にsender usernameが含まれていること' do
      expect(mail.html_part.body.raw_source).to include(sender.username)
      expect(mail.text_part.body.raw_source).to include(sender.username)
    end

    it '本文にlinkが含まれていること' do
      expect(mail.html_part.body.raw_source).to match(%r{#{Rails.configuration.x.app.client_url}/link/comments/\w{14}})
    end
  end
end
