class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details,dependent: :destroy

  def full_name
    customer.last_name + " " + customer.first_name
  end

  enum payment_method: {credit_card: 0, transfer: 1 }
  enum status: {payment_wait: 0,payment_confirm: 1,making: 2,shipping_preparation: 3,shipped: 4}
end
