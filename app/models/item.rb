class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :condition
  belongs_to :prefecture
  belongs_to :when_will_send
  belongs_to :category
  belongs_to :postage
  belongs_to :user
  has_one_attached :image

  validates :title, presence: true
  validates :price, only_integer: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  validates :explanation, presence: true
  validates :image, presence: true

  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :when_will_send_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :postage_id, numericality: { other_than: 1 , message: "can't be blank"}
  
  def was_attached?
    self.image.attached?
  end
end
