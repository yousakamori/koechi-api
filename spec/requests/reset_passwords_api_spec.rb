require 'rails_helper'

RSpec.describe 'ResetPasswords API', type: :request do
  let(:user) { create(:user) }

  describe 'POST /reset_password/' do
    it 'パスワード更新メールを送信' do
      post '/reset_password', params: { email: user.email }

      expect(response).to have_http_status :no_content
    end
  end

  # describe 'GET /reset_password/check_token' do
  #   it 'tokenのチェック' do
  #     get '/reset_password/check_token'
  #   end
  # end

  # describe 'PUT /reset_password/' do
  #   it 'パスワードの更新' do
  #     put '/reset_password', params: { password: 'newPassword' }

  #     expect(response).to have_http_status :no_content
  #     expect(User.password).to eq('newPassword')
  #   end
  # end
end
