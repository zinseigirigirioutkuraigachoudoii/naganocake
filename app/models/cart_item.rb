class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  def line_total
    item.price * quantity
  end
end
