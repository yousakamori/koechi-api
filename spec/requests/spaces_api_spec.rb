require 'rails_helper'

RSpec.describe 'Spaces API', type: :request do
  include SessionHelper
  let(:user) { create(:user) }

  describe 'GET /spaces/:slug' do
    it 'spaceの詳細' do
      log_in_as(user.email, 'passw0rd')
      space = create(:space, :with_memberships, owner: user)
      get "/spaces/#{space.slug}"

      expect(response).to have_http_status :ok
    end
  end

  describe 'POST /spaces/' do
    it 'spaceの作成' do
      log_in_as(user.email, 'passw0rd')

      expect { post '/spaces', params: { name: 'スペース名', emoji: '🐸' } }.to change(Space, :count).by(+1)
      expect(response).to have_http_status :ok
    end
  end

  describe 'PUT /spaces/' do
    it 'spaceの編集' do
      log_in_as(user.email, 'passw0rd')
      space = create(:space, name: 'old name', emoji: '🐸', owner: user)
      put "/spaces/#{space.slug}", params: { name: 'new name', emoji: '🦁' }

      expect(response).to have_http_status :no_content
      expect(Space.last.name).to eq('new name')
    end
  end

  describe 'DELETE /spaces/' do
    it 'spaceの削除' do
      log_in_as(user.email, 'passw0rd')
      space = create(:space, archived: true, owner: user)

      expect { delete "/spaces/#{space.slug}" }.to change(Space, :count).by(-1)
      expect(response).to have_http_status :no_content
    end
  end
end
