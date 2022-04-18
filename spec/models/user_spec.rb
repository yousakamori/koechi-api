require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Eメール' do
    it '重複は無効' do
      create(:user, email: 'duplicate@example.com')
      user = build(:user, email: 'duplicate@example.com')
      user.valid?
      expect(user.errors[:email]).to include('はすでに登録済です')
    end

    it '小文字で保存されていること' do
      user = build(:user, email: 'TeSt@example.com')
      user.save!
      expect(user.reload.email).to eq 'test@example.com'
    end

    context '形式が正しい' do
      it '有効' do
        user = build(:user, email: 'user@example.com')
        expect(user).to be_valid

        user = build(:user, email: 'USER@foo.COM')
        expect(user).to be_valid

        user = build(:user, email: 'A_US-ER@foo.bar.org')
        expect(user).to be_valid
      end
    end

    context '形式が間違っている' do
      it '無効' do
        user = build(:user, email: 'user@example,com')
        expect(user).to be_invalid

        user = build(:user, email: 'user_at_foo.org')
        expect(user).to be_invalid

        user = build(:user, email: 'foo@bar+baz.com')
        expect(user).to be_invalid
      end
    end
  end

  describe 'パスワード' do
    context '形式が正しい(半角英数 + _!@#$%)' do
      it '有効' do
        user = build(:user, password: 'a' * 8)
        expect(user).to be_valid

        user = build(:user, password: 'a' * 32)
        expect(user).to be_valid

        user = build(:user, password: 'Pass12345')
        expect(user).to be_valid

        user = build(:user, password: 'Pass_!@#$%')
        expect(user).to be_valid
      end
    end

    context '形式が間違っている' do
      it '無効' do
        user = build(:user, password: 'a' * 7)
        expect(user).to be_invalid

        user = build(:user, password: 'a' * 33)
        expect(user).to be_invalid

        user = build(:user, password: 'あいうえおかきく')
        expect(user).to be_invalid
      end
    end
  end

  describe 'アバター' do
    it { is_expected.to validate_content_type_of(:avatar).allowing('image/png', 'image/jpg', 'image/jpeg', 'image/gif') }
    it { is_expected.to validate_content_type_of(:avatar).rejecting('text/plain', 'text/xml') }
    it { is_expected.to validate_size_of(:avatar).less_than(5.megabytes) }
  end

  describe 'ユーザー名' do
    let(:user) { create(:user) }

    it '更新時に重複は無効' do
      create(:user, username: 'duplicate')
      user = create(:user)
      user.update(username: 'duplicate')
      expect(user.errors[:username]).to include('はすでに登録済です')
    end

    context '形式が正しい(半角英数小文字 + _)' do
      it '有効' do
        user.update(username: 'abcd_1234')
        expect(user).to be_valid

        user.update(username: 'abcd')
        expect(user).to be_valid

        user.update(username: '1234')
        expect(user).to be_valid
      end
    end

    context '形式が間違っている' do
      it '無効' do
        user.update(username: 'abcd-1234')
        expect(user).to be_invalid

        user.update(username: 'abcd@1234')
        expect(user).to be_invalid

        user.update(username: 'Abcd1234')
        expect(user).to be_invalid

        user.update(username: 'あいうえお')
        expect(user).to be_invalid
      end
    end
  end
end
