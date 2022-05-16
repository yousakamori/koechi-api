require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it 'emailは重複して登録できないこと' do
    create(:user, email: 'duplicate@example.com')
    user = build(:user, email: 'duplicate@example.com')
    user.valid?
    expect(user.errors[:email]).to include('はすでに登録済です')
  end

  it 'emailが小文字で登録されていること' do
    user = build(:user, email: 'TeSt@example.com')
    user.save!
    expect(user.reload.email).to eq 'test@example.com'
  end

  it 'emailが正しい形式のときは有効' do
    user = build(:user, email: 'user@example.com')
    expect(user).to be_valid

    user = build(:user, email: 'USER@foo.COM')
    expect(user).to be_valid

    user = build(:user, email: 'A_US-ER@foo.bar.org')
    expect(user).to be_valid
  end

  it 'emailが誤った形式のときは無効' do
    user = build(:user, email: 'user@example,com')
    expect(user).to be_invalid

    user = build(:user, email: 'user_at_foo.org')
    expect(user).to be_invalid

    user = build(:user, email: 'foo@bar+baz.com')
    expect(user).to be_invalid
  end

  it 'passwordが正しい形式のときは有効' do
    user = build(:user, password: 'a' * 8)
    expect(user).to be_valid

    user = build(:user, password: 'a' * 32)
    expect(user).to be_valid

    user = build(:user, password: 'Pass12345')
    expect(user).to be_valid

    user = build(:user, password: 'Pass_!@#$%')
    expect(user).to be_valid
  end

  it 'passwordが誤った形式のときは無効' do
    user = build(:user, password: 'a' * 7)
    expect(user).to be_invalid

    user = build(:user, password: 'a' * 33)
    expect(user).to be_invalid

    user = build(:user, password: 'あいうえおかきく')
    expect(user).to be_invalid
  end

  it { is_expected.to validate_content_type_of(:avatar).allowing('image/png', 'image/jpeg', 'image/gif') }
  it { is_expected.to validate_content_type_of(:avatar).rejecting('text/plain', 'text/xml') }
  it { is_expected.to validate_size_of(:avatar).less_than(5.megabytes) }

  it 'usernameは重複して登録できないこと' do
    create(:user, username: 'duplicatename')
    user = build(:user, username: 'duplicatename')
    user.valid?
    expect(user.errors[:username]).to include('はすでに登録済です')
  end

  it 'usernameが正しい形式のときは有効' do
    user.update(username: 'abcd_1234')
    expect(user).to be_valid

    user.update(username: 'abcd')
    expect(user).to be_valid

    user.update(username: '1234')
    expect(user).to be_valid
  end

  it 'usernameが誤った形式のときは無効' do
    user.update(username: 'abcd-1234')
    expect(user).to be_invalid

    user.update(username: 'abcd@1234')
    expect(user).to be_invalid

    user.update(username: 'Abcd1234')
    expect(user).to be_invalid

    user.update(username: 'あいうえお')
    expect(user).to be_invalid
  end

  describe '#follow and #unfollow' do
    let(:other_user) { create(:user) }

    it '#follow' do
      user.follow!(other_user.id)
      expect(user.followings).to include(other_user)
    end

    it '#unfollow' do
      user.follow!(other_user.id)
      expect(user.followings).to include(other_user)

      user.unfollow!(other_user.id)
      expect(user.followings).not_to include(other_user)
    end
  end
end
