class OrderItem < ApplicationRecord
  #注文・商品とのアソシエーション
  belongs_to :order
  belongs_to :item

  #バリデーション設定
  validates :quantity, presence: true

  #enum設定
  enum status: { unable_to_start: 0, waiting_for_production: 1,  in_production: 2, completion_of_production: 3 }
  
  def subtotal
    self.price * self.quantity
  end
end
