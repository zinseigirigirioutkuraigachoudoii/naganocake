class ShippingAddress < ApplicationRecord
  belongs_to :customer

  #バリデーション
  validates :name, :address, presence: true
  validates :address, length: { maximum: 50 }, presence: true
  validates :postcode, format: {with: /\A\d{7}\z/}, presence: true

 #配送先情報を表示するためのメソッド
  def shipping_address_display
    "〒" + postcode + " " + address + " " + name
  end
end
