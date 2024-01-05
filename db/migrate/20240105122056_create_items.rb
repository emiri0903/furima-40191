class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.integer :condition_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :when_will_send_id, null: false
      t.decimal :price, null: false
      t.integer :postage_id, null: false
      t.text :explanation, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
