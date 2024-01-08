require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user, name_kanji_sei: '山田', name_kanji_mei: '太郎', name_kana_sei: 'ヤマダ', name_kana_mei: 'タロウ')
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "user登録に必要な情報が存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end    

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end    

      it 'emailが一意でなければ登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it 'メールアドレスは@を含む必要がある' do
        @user.email = 'testexample.com'  # @ を含まない例
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid") if !@user.email.include?('@')
      end       
      
      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードは6文字以上であること' do
        @user.password = 'pass12'  # 例: 6文字以上のパスワード
        @user.valid?
        expect(@user.errors.full_messages).not_to include("Password is too short (minimum is 6 characters)")
      end

      it 'パスワードは半角英数字混合であること' do
        @user.password = 'password123'  # 例: 半角英字と数字が混在している
        @user.valid?
        expect(@user.errors.full_messages).not_to include("Password must include both letters and numbers")
      end

      it 'お名前(全角)は、名字と名前がそれぞれ必須であること' do
        @user.name_kanji_sei = ''  # 空の名字
        @user.name_kanji_mei = ''  # 空の名前
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kanji sei can't be blank", "Name kanji mei can't be blank")
      end     

      it 'お名前(全角)は、全角での入力が必須であること' do
        @user.name_kanji_sei = 'Smith'  # 半角の名字
        @user.name_kanji_mei = 'John'   # 半角の名前
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kanji sei is invalid", "Name kanji mei is invalid")
      end      

      it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
        @user.name_kana_sei = 'すみす'  # 全角ひらがなの姓
        @user.name_kana_mei = 'たろう'  # 全角ひらがなの名前
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana sei is invalid", "Name kana mei is invalid")
      end

      it '生年月日が必須であること' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end
    end
  end
end
