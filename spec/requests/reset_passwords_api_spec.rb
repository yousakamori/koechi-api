require 'rails_helper'

RSpec.describe 'ResetPasswords API', type: :request do
  let(:user) { create(:user) }

  describe 'POST /reset_password/' do
    it 'パスワード更新メールを送信' do
      post '/reset_password', params: { email: user.email }

      expect(response).to have_http_status :no_content
    end

    it 'メールが送信されること' do
      expect do
        post '/reset_password', params: { email: user.email }
      end.to have_enqueued_job(ActionMailer::MailDeliveryJob)
    end
  end

  describe 'GET /reset_password/check_token' do
    it 'tokenが有効なこと' do
      token = user.signed_id(expires_in: 1.minute, purpose: :reset_password)
      get "/reset_password/check_token?token=#{token}"
      json = JSON.parse(response.body)

      expect(json['valid_token']).to be_truthy
    end

    it 'tokenが違う場合は無効なこと' do
      get '/reset_password/check_token?token=badtoken'
      json = JSON.parse(response.body)

      expect(json['valid_token']).to be_falsey
    end

    it '有効期限切れの場合は無効なこと' do
      token = user.signed_id(expires_in: 1.minute, purpose: :reset_password)
      travel 2.minutes
      get "/reset_password/check_token?token=#{token}"
      json = JSON.parse(response.body)

      expect(json['valid_token']).to be_falsey
    end
  end

  describe 'PUT /reset_password/' do
    it 'パスワードの更新' do
      token = user.signed_id(expires_in: 1.minute, purpose: :reset_password)
      put '/reset_password', params: { token: token, password: 'newPassword' }

      expect(response).to have_http_status :no_content
    end
  end
end
