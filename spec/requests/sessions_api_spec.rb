require 'rails_helper'

RSpec.describe 'Sessions API', type: :request do
  include SessionHelper
  let(:user) { create(:user) }

  describe 'POST /login' do
    it 'ログイン' do
      log_in_as(user.email, 'passw0rd')

      expect(is_logged_in?).to be_truthy
      expect(response).to have_http_status :success
    end
  end

  describe 'DELETE /logout' do
    it 'ログアウト' do
      log_in_as(user.email, 'passw0rd')
      delete '/logout'

      expect(is_logged_in?).to be_falsey
      expect(response).to have_http_status :no_content
    end
  end
end
