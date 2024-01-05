class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :name_kanji_sei, presence: true
  validates :name_kanji_mei, presence: true
  validates :name_kana_sei, presence: true
  validates :name_kana_mei, presence: true
  validates :birth_day, presence: true

  has_many :items
  has_many :purchase_histories

end
