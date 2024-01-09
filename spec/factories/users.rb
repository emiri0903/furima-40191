FactoryBot.define do
  factory :user do
    nickname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { "password+123" }
    password_confirmation { "password+123" }
    name_kanji_sei { Faker::Name.first_name }
    name_kanji_mei { Faker::Name.last_name }
    name_kana_sei { Faker::Name.first_name }
    name_kana_mei { Faker::Name.last_name }
    birth_day { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
