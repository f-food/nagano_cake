class CartItem < ApplicationRecord

  belongs_to :item
  belongs_to :customer

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  # 小計を計算
  def subtotal
    item.add_tax_price * quantity
  end
end
