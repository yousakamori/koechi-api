require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'likable_typeがCommentかNoteかTalkなら有効' do
    like = build(:like, :for_comment)
    expect(like).to be_valid

    like = build(:like, :for_note)
    expect(like).to be_valid

    like = build(:like, :for_talk)
    expect(like).to be_valid
  end

  it 'likable_typeがCommentかNoteかTalk以外なら無効' do
    like = build(:like, :for_user)
    like.valid?

    expect(like.errors[:likable_type]).to include('は一覧にありません')
  end

  it 'titleの返り値が正しい' do
    like = create(:like, :for_comment)
    expect(like.title).to eq('comment body')

    like = create(:like, :for_talk)
    expect(like.title).to eq('talk title')

    like = create(:like, :for_note)
    expect(like.title).to eq('note title')
  end

  it 'posted_atの返り値が正しい' do
    like = create(:like, :for_comment)
    expect(like.posted_at).to eq(like.likable.created_at)

    like = create(:like, :for_talk)
    expect(like.posted_at).to eq(like.likable.created_at)

    like = create(:like, :for_note)
    expect(like.posted_at).to eq(like.likable.posted_at)
  end

  it 'shortlink_pathの返り値が正しい' do
    like = create(:like, :for_comment)
    expect(like.shortlink_path).to eq("/link/comments/#{like.likable.slug}")
  end
end
