require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      user = User.new(nickname: '', email: 'test@example', password: '000000', password_confirmation: '000000')
      user.valid?
      expect(user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      user = User.new(nickname: 'test', email: '', password: '000000', password_confirmation: '000000')
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    it 'emailが一意でなければ登録できない' do
      existing_user = User.create(nickname: 'existing', email: 'existing@example.com', password: '000000', password_confirmation: '000000')
      user = User.new(nickname: 'test', email: 'existing@example.com', password: '000000', password_confirmation: '000000')
      user.valid?
      expect(user.errors.full_messages).to include("Email has already been taken")
    end
    it 'メールアドレスは@を含む必要がある' do
      user = User.new(nickname: 'test', email: 'invalid_email', password: '000000', password_confirmation: '000000')
      user.valid?
      expect(user.errors.full_messages).to include("Email is invalid")
    end    
    it 'passwordが空だと登録できない' do
      user = User.new(nickname: 'abe', email: 'kkk@gmail.com', password: '', password_confirmation: '00000000')
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードは6文字以上であること' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: '12345', password_confirmation: '12345')
      user.valid?
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'パスワードは半角英数字混合であること' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'password')
      user.valid?
      expect(user.errors.full_messages).to include("Password must include both letters and numbers")
    end
    it 'パスワードとパスワード（確認）は値の一致が必須であること' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'different_password')
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'お名前(全角)は、名字と名前がそれぞれ必須であること' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'password', name_kanji_sei: '', name_kanji_mei: '')
      user.valid?
      expect(user.errors.full_messages).to include("Name kanji sei can't be blank", "Name kanji mei can't be blank")
    end
    it 'お名前(全角)は、全角での入力が必須であること' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'password', name_kanji_sei: 'Smith', name_kanji_mei: 'John')
      user.valid?
      expect(user.errors.full_messages).to include("Name kanji sei is invalid", "Name kanji mei is invalid")
    end
    it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'password', name_kana_sei: 'すみす', name_kana_mei: 'たろう')
      user.valid?
      expect(user.errors.full_messages).to include("Name kana sei is invalid", "Name kana mei is invalid")
    end
    it '生年月日が必須であること' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'password', birth_day: nil)
      user.valid?
      expect(user.errors.full_messages).to include("Birth day can't be blank")
    end
  end
end
