FactoryBot.define do
  factory :user do
    nickname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    name_kanji_sei { Faker::Name.first_name }
    name_kanji_mei { Faker::Name.last_name }
    name_kana_sei { Faker::Name.first_name }
    name_kana_mei { Faker::Name.last_name }
    birth_day { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
