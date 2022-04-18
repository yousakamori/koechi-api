require 'rails_helper'

RSpec.describe 'Mes API', type: :request do
  let(:user) { create(:user) }
  let(:not_activated_user) { create(:user, :not_activated) }

  describe 'GET /me' do
    it 'ステータスが200' do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session)
        .and_return({ user_last_access_time: Time.current, user_id: user.id })

      get '/me'
      expect(response).to have_http_status :ok
    end
  end

  describe 'PUT /me' do
    it 'ステータスが200' do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session)
        .and_return({ user_last_access_time: Time.current, user_id: user.id })
      put '/me', params: { name: 'jiro', bio: '私の名前は次郎です。' }
      expect(response).to have_http_status :ok

      json = JSON.parse(response.body)

      expect(json['name']).to eq('jiro')
      expect(json['bio']).to eq('私の名前は次郎です。')
    end
  end

  describe 'DELETE /me' do
    it 'ユーザを削除する' do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session)
        .and_return({ user_last_access_time: Time.current, user_id: user.id })

      expect do
        delete '/me', params: { password: 'passw0rd' }
      end.to change(User, :count).by(-1)

      expect(response).to have_http_status :no_content
    end
  end
end
