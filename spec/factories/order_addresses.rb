FactoryBot.define do
  factory :order_address do
    post_number { '123-45667' }
    prefecture_id { 3 }
    city { '東京都' }
    address_number { '足立区' }
    building_name { '西新井ビル' }
    phone_number { '08012345678' }
    price { 3000 }
    token { 'hogehoge' }
    user { association :user }
    item { association :item }
  end
end
