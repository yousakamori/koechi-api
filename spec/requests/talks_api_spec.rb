require 'rails_helper'

RSpec.describe 'Talks API', type: :request do
  include SessionHelper
  let(:user) { create(:user) }

  describe 'GET /talks' do
    it 'talkの一覧' do
      create(:talk)
      get '/talks'

      expect(response).to have_http_status :ok
    end
  end

  describe 'GET /talks/:slug' do
    it 'talkの詳細' do
      talk = create(:talk)
      get "/talks/#{talk.slug}"

      expect(response).to have_http_status :ok
    end
  end

  describe 'POST /talks/' do
    it 'talkの作成' do
      log_in_as(user.email, 'passw0rd')

      expect { post '/talks', params: { title: 'new talk title' } }.to change(Talk, :count).by(+1)
      expect(response).to have_http_status :ok
    end
  end

  describe 'PUT /talks/' do
    it 'talkの編集' do
      log_in_as(user.email, 'passw0rd')
      talk = create(:talk, title: 'new talk title', user: user)
      put "/talks/#{talk.slug}", params: { title: 'edit talk title' }

      expect(response).to have_http_status :no_content
      expect(Talk.first.title).to eq('edit talk title')
    end
  end

  describe 'DELETE /talks/' do
    it 'talkの削除' do
      log_in_as(user.email, 'passw0rd')
      talk = create(:talk, title: 'title', user: user)

      expect { delete "/talks/#{talk.slug}" }.to change(Talk, :count).by(-1)
      expect(response).to have_http_status :no_content
    end
  end
end
