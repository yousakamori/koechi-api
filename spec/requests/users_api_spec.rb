require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'POST /users' do
    it 'ユーザを作成する' do
      # TODO: 修正 => https://qiita.com/piggydev/items/9e767a1f908774203c5e

      # allow(UserMailer).to receive_message_chain(:confirmation_email, :deliver_later)

      expect do
        post '/users', params: { email: 'test@example.com' }
      end.to change(User, :count).by(+1)

      expect(response).to have_http_status :no_content
      # expect(UserMailer).to have_received(:confirmation_email).once
    end
  end
end
