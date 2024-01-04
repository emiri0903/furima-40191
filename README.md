# users テーブル
| Column             | Type              | Options     |
| ------------------ | ----------------- | ----------- |
| name               | string            | null: false |
| email              | string            | null: false |
| password_digest    | string            | null: false |

# purchases テーブル
| Column            | Type   | Options     |
| ----------------- | ------ | ----------- |
| post_number       | string | null: false |
| prefecture        | string | null: false |
| city              | text   | null: false |
| address_number    | text   | null: false |
| building_name     | text   | null: false |
| phone_number      | text   | null: false |

# comments テーブル
| Column  | Type    | Options                       |
| ------- | ------- | ------------------------------ |
| content | text    | null: false                   |
| item_id | reference| null: false, foreign_key: true|
| user_id | reference| null: false, foreign_key: true|

# items テーブル
| Column         | Type    | Options                        |
| -------------- | ------- | ------------------------------ |
| title          | text    | null: false                    |
| condition      | text    | null: false                    |
| seller_id      | reference| null: false, foreign_key: true |
| from_where     | text    | null: false                    |
| when_will_send | text    | null: false                    |
| category       | text    | null: false                    |
| price          | text    | null: false                    |
| explanation    | text    | null: false                    |
| photo          | string  | null: false                    |
| postage        | text    | null: false                    |

# Association
- has_many :comments
- has_one  :purchase

# Association
- has_one :user

# Association
- belongs_to :item
- belongs_to :user

