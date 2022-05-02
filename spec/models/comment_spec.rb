require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'body_jsonがあれば有効' do
    comment = build(:comment, body_json: 'new body')

    expect(comment).to be_valid
  end

  it 'body_jsonがなければ無効' do
    comment = build(:comment, body_json: nil)
    comment.valid?

    expect(comment.errors[:body_json]).to include('を入力してください')
  end

  it 'commetable_typeがNoteかTalkなら有効' do
    comment = build(:comment, :for_note)
    expect(comment).to be_valid

    comment = build(:comment, :for_talk)
    expect(comment).to be_valid
  end

  it 'commetable_typeがNoteとTalk以外なら無効' do
    comment = build(:comment, :for_like)
    comment.valid?

    expect(comment.errors[:commentable_type]).to include('は一覧にありません')
  end
end
