class AddLarstNameKanaToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :last_name_kana, :string
  end
end
