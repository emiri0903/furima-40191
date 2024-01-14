class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :edit]
  before_action :set_item, only: [:edit, :update, :show]
  before_action :move_to_index, except: [:index, :show, :edit, :update]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    unless user_signed_in? && @item.user == current_user
      redirect_to user_session_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :condition_id, :prefecture_id, :when_will_send_id, :category_id, :price, :explanation, :postage_id, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
  def move_to_index
    unless @item.user == current_user
      redirect_to action: :index
    end
  end
end