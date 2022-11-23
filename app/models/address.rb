class Address < ApplicationRecord
  belongs_to :customer

  def address_display #注文情報入力画面でプルダウンメニューに表示する内容
    "〒" + post_code + " " + address + " " + attention_name
  end

  def finally_address
    postcode + " " + address + " " + name
  end
end
