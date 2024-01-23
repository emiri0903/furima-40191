require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '配送情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address_params = FactoryBot.create(:order_address, user_id: user.id, item_id: item.id)
    end    

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end

      context '内容に問題がある場合' do
        it 'post_numberが空だと保存できないこと' do
          @order_address.post_number = ''
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Post number can't be blank")
        end
        it 'post_numberが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
          @order_address.postal_code = '1234567'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('Post number is invalid. Include hyphen(-)')
        end
        it 'prefectureを選択していないと保存できないこと' do
          @order_address.prefecture_id = 1
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
        end
        it 'cityが空だと保存できないこと' do
          @order_address.city = ''
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("City can't be blank")
        end
        it 'address_numberが空だと保存できないこと' do
          @order_address.address_number = ''
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Address number can't be blank")
        end
        it 'phone_numberが空だと保存できないこと' do
          @order_address.phone_number = ''
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
        end
        it 'phone_numberが9ケタだと保存できないこと' do
          @order_address.phone_number = '123456789'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Phone number is too short (minimum is 10 characters)")
        end
        it 'phone_numberが12ケタだと保存できないこと' do
          @order_address.phone_number = '012345678912'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
        end
        it 'phone_numberにハイフンが入っていると保存できないこと' do
          @order_address.phone_number = '080-1234-5678'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Phone number doesn't need -")
        end
        it 'priceが空だと保存できないこと' do
          @order_address.price = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Price can't be blank")
        end
        it 'priceが全角数字だと保存できないこと' do
          @order_address.price = '２０００'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('Price is invalid')
        end
        it 'priceが300円未満では保存できないこと' do
          @order_address.price = 0
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('Price is invalid')
        end
        it 'priceが9,999,999円を超過すると保存できないこと' do
          @order_address.price = 1000001
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('Price is invalid')
        end
        it 'userが紐付いていないと保存できないこと' do
          @order_address.user_id = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("User can't be blank")
        end
        it 'itemが紐付いていないと保存できないこと' do
          @order_address.item_id = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Item can't be blank")
        end
        it 'tokenが空だと保存できないこと' do
          @order_address.token = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Token can't be blank")
        end
      end
    end
  end
end