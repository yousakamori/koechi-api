require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'POST /users' do
    it 'ユーザが作成されること' do
      expect do
        post '/users', params: { email: 'test@example.com' }
      end.to change(User, :count).by(+1)

      expect(response).to have_http_status :no_content
    end

    it '確認メールが送信されること' do
      expect do
        post '/users', params: { email: 'test@example.com' }
      end.to have_enqueued_job(ActionMailer::MailDeliveryJob)
    end
  end
end
