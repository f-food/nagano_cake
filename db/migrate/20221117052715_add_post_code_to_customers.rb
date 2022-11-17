class AddPostCodeToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :post_code, :string
  end
end
