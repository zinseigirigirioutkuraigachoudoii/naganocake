class Order < ApplicationRecord
  belongs_to :customer

  #商品・注文商品とのアソシエーション
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  #バリデーション設定
  validates :payment, :name, :postcode, :address, presence: true

  #enum設定
  enum payment: { クレジットカード: 0, 銀行振込: 1 }
  enum status: { waiting_for_payment: 0, confirmation_of_payment: 1, in_production: 2, preparing_to_ship: 3, shipped: 4  }

  def customer_address
    "〒" + customer.postcode + " " + customer.address + " " + customer.last_name + customer.first_name
  end

  def include_postage
   self.total + self.postage
  end

  def subtotal
    price * item.quantity
  end
end
