class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_details, dependent: :destroy
  belongs_to :genre
  has_one_attached :image

  #消費税の計算
  def add_tax_price
    (self.excluded_price * 1.08).round
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