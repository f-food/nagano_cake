class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  belongs_to :genre
  has_one_attached :image
  enum is_status: [:販売可, :販売不可]
end
