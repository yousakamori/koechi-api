require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'confirmation_email' do
    magic_link = 'http://localhost:3000/update_email?token=eyJfcmFpbHMiOnsibWVzc2FnZSI6Ik1qVT0iLCJleHAiOiIyMDIyLTA1LTA0VDA4OjE2OjU4LjA2MVoiLCJwdXIiOiJ1c2VyL2VtYWlsX2FjdGl2YXRlIn19--b4a2b10f6c3e2194d04a244400953e4273921149610dbe1fbef153a3f49399f3'
    token_expiration_time = '60分'

    let(:user) { create(:user) }
    let(:mail) { described_class.confirmation_email(user, magic_link, token_expiration_time) }

    it '送信先がユーザーのメールアドレスであること' do
      expect(mail.to).to eq [user.email]
    end

    it '正しい送信元であること' do
      expect(mail.from).to eq ['noreply@koechi.com']
    end

    it '正しい件名であること' do
      expect(mail.subject).to eq 'メールアドレスの確認'
    end

    it '本文にmagic linkが含まれていること' do
      expect(mail.html_part.body.raw_source).to include(CGI.escape_html(magic_link))
      expect(mail.text_part.body.raw_source).to include(magic_link)
    end

    it '本文に有効期限が含まれていること' do
      expect(mail.html_part.body.raw_source).to include(token_expiration_time)
      expect(mail.text_part.body.raw_source).to include(token_expiration_time)
    end
  end

  describe 'reset_password' do
    magic_link = 'http://localhost:3000/update_password?token=eyJfcmFpbHMiOnsibWVzc2FnZSI6Ik1qVT0iLCJleHAiOiIyMDIyLTA1LTA0VDA4OjE2OjU4LjA2MVoiLCJwdXIiOiJ1c2VyL2VtYWlsX2FjdGl2YXRlIn19--b4a2b10f6c3e2194d04a244400953e4273921149610dbe1fbef153a3f49399f3'
    token_expiration_time = '60分'

    let(:user) { create(:user) }
    let(:mail) { described_class.confirmation_email(user, magic_link, token_expiration_time) }

    it '送信先がユーザーのメールアドレスであること' do
      expect(mail.to).to eq [user.email]
    end

    it '正しい送信元であること' do
      expect(mail.from).to eq ['noreply@koechi.com']
    end

    it '正しい件名であること' do
      expect(mail.subject).to eq 'メールアドレスの確認'
    end

    it '本文にmagic linkが含まれていること' do
      expect(mail.html_part.body.raw_source).to include(CGI.escape_html(magic_link))
      expect(mail.text_part.body.raw_source).to include(magic_link)
    end

    it '本文に有効期限が含まれていること' do
      expect(mail.html_part.body.raw_source).to include(token_expiration_time)
      expect(mail.text_part.body.raw_source).to include(token_expiration_time)
    end
  end

  describe 'reset_email' do
    magic_link = 'http://localhost:3000/login_with_email?token=eyJfcmFpbHMiOnsibWVzc2FnZSI6Ik1qVT0iLCJleHAiOiIyMDIyLTA1LTA0VDA4OjE2OjU4LjA2MVoiLCJwdXIiOiJ1c2VyL2VtYWlsX2FjdGl2YXRlIn19--b4a2b10f6c3e2194d04a244400953e4273921149610dbe1fbef153a3f49399f3&password=4NiYx3eLZcRCR5z8xz5u'
    token_expiration_time = '60分'

    let(:user) { create(:user) }
    let(:mail) { described_class.confirmation_email(user, magic_link, token_expiration_time) }

    it '送信先がユーザーのメールアドレスであること' do
      expect(mail.to).to eq [user.email]
    end

    it '正しい送信元であること' do
      expect(mail.from).to eq ['noreply@koechi.com']
    end

    it '正しい件名であること' do
      expect(mail.subject).to eq 'メールアドレスの確認'
    end

    it '本文にmagic linkが含まれていること' do
      expect(mail.html_part.body.raw_source).to include(CGI.escape_html(magic_link))
      expect(mail.text_part.body.raw_source).to include(magic_link)
    end

    it '本文に有効期限が含まれていること' do
      expect(mail.html_part.body.raw_source).to include(token_expiration_time)
      expect(mail.text_part.body.raw_source).to include(token_expiration_time)
    end
  end
end
