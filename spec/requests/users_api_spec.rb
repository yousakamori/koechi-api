require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'POST /users' do
    it 'ユーザを作成する' do
      expect do
        post '/users', params: { email: 'test@example.com' }
      end.to change(User, :count).by(+1)

      expect(response).to have_http_status :no_content
    end
  end
end
