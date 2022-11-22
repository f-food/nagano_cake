class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_details, dependent: :destroy
  belongs_to :genre
  has_one_attached :image


  validates :image, presence: true
  validates :name, presence: true
  validates :caption, presence: true
  validates :genre_id, presence: true
  validates :excluded_price, presence: true
  validates :is_status, presence: true


  def add_tax_price
    (self.excluded_price * 1.10).round
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width,height]).processed
  end



#消費財のメソッド
  def with_tax_price
    (price * 1.1).floor
  end

end