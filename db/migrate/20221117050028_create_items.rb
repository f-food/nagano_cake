class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id
      t.string :name
      t.integer :excluded_price
      t.text :caption
      t.boolean :is_status
      t.timestamps
    end
  end
end
