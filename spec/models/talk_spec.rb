require 'rails_helper'

RSpec.describe Talk, type: :model do
  it 'titleがあれば有効' do
    talk = build(:talk, title: 'トークのタイトル')
    expect(talk).to be_valid
  end

  it 'slugが登録されていること' do
    talk = create(:talk, title: 'トークのタイトル')
    expect(talk.slug).to be_present
  end
end
