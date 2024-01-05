class CreateFurimas < ActiveRecord::Migration[7.0]
  def change
    create_table :furimas do |t|

      t.timestamps
    end
  end
end
