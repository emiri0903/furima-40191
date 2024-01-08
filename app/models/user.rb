class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :name_kanji_sei, presence: true
  validates :name_kanji_mei, presence: true
  validates :name_kanji_sei, :name_kanji_mei, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: "is invalid" }
  validates :name_kana_sei, presence: true
  validates :name_kana_mei, presence: true
  validates :name_kana_sei, :name_kana_mei, format: { with: /\A[ァ-ヶー－]+\z/, message: "is invalid" }
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "must include both letters and numbers" }
  validates :birth_day, presence: true

  # has_many :items
  # has_many :purchase_histories

end
