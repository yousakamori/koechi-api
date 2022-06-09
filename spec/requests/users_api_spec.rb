require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { create(:user) }
  let(:other_users) { create_list(:user, 20) }

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

  describe 'GET /users/:username/followings' do
    it 'フォロー 一覧' do
      other_users.each do |other_user|
        user.follow!(other_user.id)
      end

      get "/users/#{user.username}/followings"
      json = JSON.parse(response.body)

      expect(response).to have_http_status :ok
      expect(json['users'].count).to eq 20
    end
  end

  describe 'GET /users/:username/followers' do
    it 'フォロワー 一覧' do
      other_users.each do |other_user|
        other_user.follow!(user.id)
      end

      get "/users/#{user.username}/followers"
      json = JSON.parse(response.body)

      expect(response).to have_http_status :ok
      expect(json['users'].count).to eq 20
    end
  end
end
