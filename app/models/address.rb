class Address < ApplicationRecord
  belongs_to :customer
  def finally_address
    postcode + " " + address + " " + name
  end
end
