FactoryBot.define do
  factory :order do
    price { 3000 }
    user { association :user }  # associationメソッドを使用して適切なuserデータを生成
    post_number { "123-4567" }
    prefecture_id { 3 }
    city { "町田" }
    address_number { "東京都" }
    building_name { "hoge" }
    phone_number { "08012345678" }
    item { 7 }  # 適切なitemデータを生成
    token { "hoge" }
  end
end
