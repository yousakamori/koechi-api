require 'rails_helper'

RSpec.describe 'Comments API', type: :request do
  include SessionHelper
  let(:user) { create(:user) }
  let(:note) { create(:note) }

  describe 'POST /comments/' do
    it 'commentの作成' do
      log_in_as(user.email, 'passw0rd')
      expect do
        post '/comments',
             params: { body_text: 'comment body',
                       body_json: '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"comment body"}]}]}',
                       parent_id: nil, commentable_id: note.id, commentable_type: 'Note', user: user }
      end.to change(Comment, :count).by(+1)

      expect(response).to have_http_status :ok
    end
  end

  describe 'PUT /comments/' do
    it 'commentの編集' do
      log_in_as(user.email, 'passw0rd')
      comment = create(:comment, user: user)
      put "/comments/#{comment.slug}", params: { body_text: 'new body' }

      expect(response).to have_http_status :no_content
      expect(Comment.first.body_text).to eq('new body')
    end
  end

  describe 'DELETE /comments/' do
    it 'commentの削除' do
      log_in_as(user.email, 'passw0rd')
      comment = create(:comment, user: user)

      expect { delete "/comments/#{comment.slug}" }.to change(Comment, :count).by(-1)
      expect(response).to have_http_status :no_content
    end
  end
end
