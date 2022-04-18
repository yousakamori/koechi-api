require 'rails_helper'

RSpec.describe 'Me::Notes API', type: :request do
  # include SessionHelper

  # before do
  #   user = create(:user)
  #   log_in_as(user.email, 'passw0rd')
  # end

  # describe 'GET /notes/' do
  #   before do
  #     create_list(:comment, 100)
  #     get '/notes'
  #   end

  #   it 'ステータスが200' do
  #     expect(response).to have_http_status :ok
  #   end

  #   it '25件のデータが帰ってくる' do
  #     json = JSON.parse(response.body)
  #     expect(json.length).to eq(25)
  #   end
  # end

  # describe 'GET /notes/:id' do
  #   let(:note) { create(:note, :with_comments) }

  #   it 'ステータスが200' do
  #     get "/notes/#{note.id}"
  #     expect(response).to have_http_status :ok
  #   end

  #   it 'ノートを取得' do
  #     get "/notes/#{note.id}"
  #     json = JSON.parse(response.body)
  #     expect(note.title).to eq json['title']
  #     expect(note.body).to eq json['body']
  #     expect(note.comments.first.body).to eq json['comments'][0]['body']
  #   end
  # end

  # describe 'POST /notes' do
  #   it 'ノートを作成する' do
  #     expect do
  #       post '/notes', params: { title: 'new title', body: 'new body' }
  #     end.to change(Note, :count).by(+1)
  #     expect(response).to have_http_status :created
  #   end
  # end

  # describe 'PUT /notes/:id' do
  #   let(:note) { create(:note) }

  #   it 'ステータスが200' do
  #     put "/notes/#{note.id}", params: { title: 'new title', body: 'new body' }
  #     expect(response).to have_http_status :ok
  #   end

  #   it 'ノートを更新する' do
  #     put "/notes/#{note.id}", params: { title: 'new title', body: 'new body' }
  #     json = JSON.parse(response.body)
  #     expect(json['title']).to eq('new title')
  #     expect(json['body']).to eq('new body')
  #   end
  # end

  # describe 'DELETE /notes/:id' do
  #   it 'ノートを削除する' do
  #     note = create(:note)
  #     expect do
  #       delete "/notes/#{note.id}"
  #     end.to change(Note, :count).by(-1)

  #     expect(response).to have_http_status :no_content
  #   end
  # end
end
