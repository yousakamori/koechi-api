require 'rails_helper'

RSpec.describe 'Mes API', type: :request do
  include SessionHelper
  let(:user) { create(:user) }

  describe 'GET /me' do
    it 'current userの詳細' do
      log_in_as(user.email, 'passw0rd')

      get '/me'
      expect(response).to have_http_status :ok
    end
  end

  describe 'PUT /me' do
    it 'current userの更新' do
      log_in_as(user.email, 'passw0rd')

      put '/me', params: { name: 'jiro', bio: '私の名前は次郎です。' }
      expect(response).to have_http_status :ok

      json = JSON.parse(response.body)
      expect(json['name']).to eq('jiro')
      expect(json['bio']).to eq('私の名前は次郎です。')
    end
  end

  describe 'DELETE /me' do
    it 'current userの削除' do
      log_in_as(user.email, 'passw0rd')
      expect do
        delete '/me', params: { password: 'passw0rd' }
      end.to change(User, :count).by(-1)

      expect(response).to have_http_status :no_content
    end
  end

  describe 'GET /liked' do
    it 'likeしているか' do
      log_in_as(user.email, 'passw0rd')
      like = create(:like, user: user)
      get "/me/liked?likable_id=#{like.likable_id}&likable_type=#{like.likable_type}"
      json = JSON.parse(response.body)

      expect(json['liked']).to be_truthy
      expect(response).to have_http_status :ok
    end
  end
end
