class OrderAddress
  include ActiveModel::Model
  attr_accessor :price, :post_number, :prefecture_id, :city, :address_number, :building_name, :phone_number, :token, :user_id, :item_id

  with_options presence: true do
    validates :token
    validates :post_number, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address_number
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
    validates :user_id
    validates :item_id
  end

  def save
    user = User.find(user_id)
    item = Item.find(item_id)
    buying_history = BuyingHistory.create(user: user, item: item)

    address = Address.create(
      post_number: post_number,
      prefecture_id: prefecture_id,
      city: city,
      address_number: address_number,
      building_name: building_name,
      phone_number: phone_number,
      buying_history_id: buying_history.id
    )
  end
end
