require 'rails_helper'

RSpec.describe Space, type: :model do
  it 'emojiとnameがあれば有効' do
    space = build(:space, emoji: '😁', name: 'スペースのタイトル')
    expect(space).to be_valid
  end

  it 'nameがないと無効' do
    space = build(:space, emoji: '😁', name: '')
    space.valid?

    expect(space.errors[:name]).to include('を入力してください')
  end

  it 'emojiがないと無効' do
    space = build(:space, emoji: '', name: 'スペースタイトル')
    space.valid?

    expect(space.errors[:emoji]).to include('を入力してください')
  end

  it 'emojiが複数文字のときは最初の文字だけ保存されること' do
    space = create(:space, emoji: '👨‍👩‍👧‍👦😁😁😁😁', name: 'スペースタイトル')

    expect(space.emoji).to eq('👨‍👩‍👧‍👦')
  end
end
