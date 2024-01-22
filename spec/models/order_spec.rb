require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '配送情報の保存' do
    before do
      @order = Order.new(price: '3000', post_number: '123-4567', prefecture_id: '2', city: '岡山市', address_number: '北区', building_name: 'hogehoge', phone_number: '08012345678')
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order.building_name = ''
        expect(@order).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'post_numberが空だと保存できないこと' do
        @order.post_number = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Post number can't be blank")
      end
      it 'post_numberが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order.post_number = '1234567'
        @order.valid?
        expect(@order.errors.full_messages).to include('Post number is invalid. Include hyphen(-)')
      end
      it 'prefecture_idを選択していないと保存できないこと' do
        @order.prefecture_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @order.city = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("City can't be blank")
      end
      it 'address_numberが空だと保存できないこと' do
        @order.address_number = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Address number can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @order.phone_number = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが9ケタだと保存できないこと' do
        @order.phone_number = '123456789'
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number is invalid")
      end
      
      it 'phone_numberが12ケタだと保存できないこと' do
        @order.phone_number = '012345678912'
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number is invalid")
      end
      
      it 'phone_numberにハイフンが入っていると保存できないこと' do
        @order.phone_number = '080-1234-5678'
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number is invalid")
      end
    end
  end
end
