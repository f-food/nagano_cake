class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :cart_items
  has_many :addresses, dependent: :destroy

  # 入力フォームのバリデーション
  validates :first_name, presence: true
  validates :last_name, presence: true
  # カタカナと長音記号のみ入力可能にする
  KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/
  validates :first_name_kana, presence: true, format: { :with => KATAKANA_REGEXP }
  validates :last_name_kana, presence: true, format: { :with => KATAKANA_REGEXP }
  # ハイフンなしの７桁のみ入力可能にする
  POST_CODE_REGEXP = /\A\d{7}\z/
  validates :post_code, presence: true, format: { :with => POST_CODE_REGEXP }
  validates :address, presence: true
  # ハイフンなしの１０桁or１１桁のみ入力可能にする
  PHONE_NUMBER_REGEXP = /\A\d{10,11}\z/
  validates :phone_number, presence: true, format: { :with => PHONE_NUMBER_REGEXP }

  def full_name
    self.last_name + " " + self.first_name
  end

  def full_name_kana
    self.last_name_kana + " " + self.first_name_kana
  end
end
