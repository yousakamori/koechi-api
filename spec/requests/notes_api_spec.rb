require 'rails_helper'

RSpec.describe 'Notes API', type: :request do
  include SessionHelper
  let(:user) { create(:user) }

  describe 'GET /notes/:slug' do
    it 'noteの詳細' do
      log_in_as(user.email, 'passw0rd')

      space = create(:space, :with_memberships, owner: user)
      note = create(:note, user: user, space: space)
      get "/notes/#{note.slug}"
      expect(response).to have_http_status :ok
    end
  end

  describe 'PUT /notes/' do
    it 'noteの編集' do
      log_in_as(user.email, 'passw0rd')
      new_posted_at = Time.current.next_day.beginning_of_day
      note = create(:note, title: 'title', body_text: 'body text',
                           body_json: 'body json', posted_at: Time.current, user: user)
      put "/notes/#{note.slug}",
          params: { title: 'new title', body_text: 'new body text', body_json: 'new body json',
                    posted_at: new_posted_at }
      expect(response).to have_http_status :no_content

      new_note = Note.last
      expect(new_note.title).to eq('new title')
      expect(new_note.body_text).to eq('new body text')
      expect(new_note.body_json).to eq('new body json')
      expect(new_note.posted_at).to eq(new_posted_at)
    end
  end

  describe 'DELETE /notes/' do
    it 'noteの削除' do
      log_in_as(user.email, 'passw0rd')

      note = create(:note, user: user)
      expect { delete "/notes/#{note.slug}" }.to change(Note, :count).by(-1)
      expect(response).to have_http_status :no_content
    end
  end
end
