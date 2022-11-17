class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :post_code
      t.string :address
      t.string :name
      t.integer :shipping_cost
      t.integer :payment_method
      t.integer :status
      t.integer :total_payment
      t.timestamps
    end
  end
end
