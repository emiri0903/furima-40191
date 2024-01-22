class Order < ApplicationRecord
  belongs_to :item
  attr_accessor :post_number, :prefecture_id, :city, :address_number, :building_name, :phone_number

  with_options presence: true do
    validates :post_number, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address_number
    validates :phone_number, format: { with: /\A\d{10}$|^\d{11}\z/ }
  end
end