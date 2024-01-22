class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_current_user
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index]
  before_action :move_to_login, only: [:index]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end

  def new
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    @item = Item.find(params[:item_id])
  
    if @item.buying_history.present?
      redirect_to root_path
    else
      if @order_address.valid?
        pay_item
        @order_address.save
        return redirect_to root_path
      else
        gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
        render 'index', status: :unprocessable_entity
      end
    end
  end

  private

  def move_to_login
    redirect_to new_user_session_path unless user_signed_in?
  end

  def order_params
    params.require(:order_address).permit(:post_number, :prefecture_id, :city, :address_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_current_user
    @current_user = current_user
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def move_to_index
    if user_signed_in?
      if current_user == @item.user || (@item.buying_history.present? && current_user != @item.user)
        redirect_to root_path
      end
    end
  end
  

  def set_item
    @item = Item.find(params[:item_id])
  end
end