class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.integer :condition_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :when_will_send_id, null: false
      t.integer :category_id, null: false
      t.integer :price, null: false, default: 0
      t.text :explanation, null: false
      t.integer :postage_id, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
