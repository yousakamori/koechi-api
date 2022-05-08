require 'rails_helper'

RSpec.describe 'Me::Notes API', type: :request do
  include SessionHelper
  let(:user) { create(:user) }

  describe 'GET /me/notes' do
    it 'note一覧' do
      log_in_as(user.email, 'passw0rd')

      space = create(:space, :with_memberships, owner: user)
      create_list(:note, 2, user: user, space: space)

      get '/me/notes'

      json = JSON.parse(response.body)

      expect(response).to have_http_status :ok
      expect(json['notes'].length).to eq 2
    end
  end

  describe 'GET /me/notes/term' do
    it 'note一覧(期間あり)' do
      log_in_as(user.email, 'passw0rd')

      now = Time.current
      space = create(:space, :with_memberships, owner: user)
      4.times do |i|
        create(:note, user: user, space: space, posted_at: now.since(i.days))
      end

      get "/me/notes/term?start=#{now.since(1.day).to_i}&end=#{now.since(2.days).to_i}"
      json = JSON.parse(response.body)

      expect(response).to have_http_status :ok
      expect(json['notes'].length).to eq 2
    end
  end
end
