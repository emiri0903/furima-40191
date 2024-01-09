require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
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
        another_user = FactoryBot.build(:user, email: @user.email)
        expect(another_user.errors.full_messages).to include("Email has already been taken") if !another_user.valid?
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
        expect(@user.errors.full_messages).to_not include("Password must include both letters and numbers")
      end
      
      it '半角英語のみでは登録できない' do
        @user.password = 'password'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must include both letters and numbers")
      end
      
      it '半角数字のみでは登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must include both letters and numbers")
      end
      
      it '全角入力では登録できないこと' do
        @user.password = 'あいうえおか'  # 例: 全角文字が含まれている
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must include both letters and numbers")
      end      
      
      it 'パスワードとパスワード（確認用）は、値の一致が必須であること' do
        @user.password_confirmation = 'different_password'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      
      it '苗字がからでは登録できない' do
        @user.name_kanji_sei = ''  # 空の名字
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kanji sei can't be blank")
      end     
      it '名前がからでは登録できない' do
        @user.name_kanji_mei = ''  # 空の名前
        @user.valid?
        errors = @user.errors.full_messages
        expect(@user.errors.full_messages).to include("Name kanji mei can't be blank")
      end     

      it 'お名前(漢字)（姓）は、全角での入力が必須であること' do
        @user.name_kanji_sei = 'Smith'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kanji sei is invalid")
      end
      it 'お名前(漢字)（名）、全角での入力が必須であること' do
        @user.name_kanji_mei = 'John'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kanji mei is invalid")
       end  

      it 'カナ（苗字）がからでは登録できない' do
        @user.name_kana_sei = ''  # 全角ひらがなの姓
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana sei can't be blank")
      end
      it 'カナ（名前）がからでは登録できない' do
        @user.name_kana_mei = ''  # 全角ひらがなの名前
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana mei can't be blank")
      end
      it '姓（カナ）に平仮名が含まれていると登録できない' do
        @user.name_kanji_sei = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana sei is invalid")
      end
      it '姓（カナ）に漢字が含まれていると登録できない' do
        @user.name_kanji_sei = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana sei is invalid")
      end
      it '姓（カナ）に英数字が含まれていると登録できない' do
        @user.name_kanji_sei = '123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana sei is invalid")
      end
      it '姓（カナ）に記号が含まれていると登録できない' do
        @user.name_kanji_sei = '¥!#'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana sei is invalid")
      end
      it '名（カナ）に平仮名が含まれていると登録できない' do
        @user.name_kanji_sei = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana mei is invalid")
      end
      it '名（カナ）に漢字が含まれていると登録できない' do
        @user.name_kanji_sei = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana mei is invalid")
      end
      it '名（カナ）に英数字が含まれていると登録できない' do
        @user.name_kanji_sei = '123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana mei is invalid")
      end
      it '名（カナ）に記号が含まれていると登録できない' do
        @user.name_kanji_sei = '¥!#'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana mei is invalid")
      end



      it '姓（漢字）に平仮名が含まれていると登録できない' do
        @user.name_kanji_sei = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kanji sei is invalid")
      end
      it '姓（漢字）にカタカナが含まれていると登録できない' do
        @user.name_kanji_sei = 'ヤマダ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kanji sei is invalid")
      end
      it '姓（漢字）に英数字が含まれていると登録できない' do
        @user.name_kanji_sei = '123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kanji sei is invalid")
      end
      it '姓（漢字）に記号が含まれていると登録できない' do
        @user.name_kanji_sei = '¥!#'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kanji sei is invalid")
      end
      it '名（漢字）に平仮名が含まれていると登録できない' do
        @user.name_kanji_sei = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kanji mei is invalid")
      end
      it '名（漢字）にカタカナが含まれていると登録できない' do
        @user.name_kanji_sei = 'タロウ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kanji mei is invalid")
      end
      it '名（漢字）に英数字が含まれていると登録できない' do
        @user.name_kanji_sei = '123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kanji mei is invalid")
      end
      it '名（漢字）に記号が含まれていると登録できない' do
        @user.name_kanji_sei = '¥!#'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kanji mei is invalid")
      end


      it '生年月日が必須であること' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end
    end
  end
end
