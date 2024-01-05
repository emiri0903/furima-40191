# users テーブル
| Column                 | Type             | Options                       |
| ---------------------- | -----------------| ----------------------------- |
| nickname               | string           | null: false                   |
| email                  | string           | null: false, unique:true      |
| encrypted_password     | string           | null: false                   |
| name_kanji_sei         | string           | null: false                   |
| name_kanji_mei         | string           | null: false                   |
| name_kana_sei          | string           | null: false                   |
| name_kana_mei          | string           | null: false                   |
| birth_day              | date             | null: false                   |

# Association
- has_many :items
- has_many :purchase_histories

# shippings テーブル
| Column                | Type   | Options     |
| --------------------- | ------ | ----------- |
| post_number           | string | null: false |
| prefecture_id         |integer | null: false |
| city                  | string | null: false |
| address_number        | string | null: false |
| building_name         | string |             |
| phone_number          | string | null: false |

# Association
- belongs_to :item
- belongs_to :purchase_histories


# items テーブル
| Column               | Type       | Options                        |
| -------------------- | -------    | ------------------------------ |
| title                | string     | null: false                    |
| condition_id         | integer    | null: false                    |
| from_where_id        | integer    | null: false                    |
| when_will_send_id    | integer    | null: false                    |
| category_id          | integer    | null: false                    |
| price                | integer    | null: false                    |
| explanation          | text       | null: false                    |
| postage_id           | integer    | null: false                    |
| user                 | references | null: false, foreign_key: true |

# Association
- belongs_to :user
- has_many :purchase_histories

# purchase_histories テーブル
| Column               | Type       | Options                        |
| -------------------- | -------    | ------------------------------ |
| item                 | references | null: false, foreign_key: true |
| user                 | references | null: false, foreign_key: true |

# Association
- belongs_to :user
- belongs_to :item
