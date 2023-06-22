class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :description
    validates :price
    validates :is_deleted
  end
  has_one_attached :image
  scope :price_high_to_low, -> { order(price: :desc) }
  scope :price_low_to_high, -> { order(price: :asc) }
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
end
