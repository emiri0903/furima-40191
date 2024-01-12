FactoryBot.define do
  factory :item do
    title { Faker::Lorem.sentence }
    condition_id { Faker::Number.between(from: 2, to: 5) } # Assuming condition_id is an integer
    prefecture_id { Faker::Number.between(from: 2, to: 47) } # Assuming prefecture_id is an integer
    when_will_send_id { Faker::Number.between(from: 2, to: 3) } # Assuming when_will_send_id is an integer
    category_id { Faker::Number.between(from: 2, to: 10) } # Assuming category_id is an integer
    postage_id { Faker::Number.between(from: 2, to: 3) } # Assuming postage_id is an integer
    price { Faker::Number.decimal(l_digits: 4, r_digits: 2) } # Assuming price is a decimal number
    explanation { Faker::Lorem.paragraph }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
