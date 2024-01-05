# users テーブル
| Column                 | Type              | Options                       |
| ---------------------- | ----------------- | ----------------------------- |
| nickname               | string            | null: false                   |
| email                  | string            | null: false, unique: true      |
| password_digest        | string            | null: false                   |
| name_kanji_sei         | string            | null: false                   |
| name_kanji_mei         | string            | null: false                   |
| name_kana_sei          | string            | null: false                   |
| name_kana_mei          | string            | null: false                   |
| birthyear              | integer           | null: false                   |
| birthmonth             | integer           | null: false                   |
| birthday               | integer           | null: false                   |

# Association
- has_many :items
- has_many :purchase_histories

# shippings テーブル
| Column                | Type   | Options     |
| --------------------- | ------ | ----------- |
| post_number           | string | null: false |
| prefecture            | string | null: false |
| city                  | string | null: false |
| address_number        | string | null: false |
| building_name         | string |             |
| phone_number          | string | null: false |

# Association
- belongs_to :item

# items テーブル
| Column               | Type    | Options                        |
| -------------------- | ------- | ------------------------------ |
| title                | string  | null: false                    |
| condition            | string  | null: false                    |
| from_where           | string  | null: false                    |
| when_will_send       | string  | null: false                    |
| category             | string  | null: false                    |
| price                | integer | null: false                    |
| explanation          | text    | null: false                    |
| postage              | string  | null: false                    |
| user_id              | integer | null: false, foreign_key: true |

# Association
- belongs_to :user
- has_many :purchase_histories

# purchase_histories テーブル
| Column               | Type    | Options                        |
| -------------------- | ------- | ------------------------------ |
| item_id              | integer | null: false, foreign_key: true |
| user_id              | integer | null: false, foreign_key: true |

# Association
- belongs_to :user
- belongs_to :item
