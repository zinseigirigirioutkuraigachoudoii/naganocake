class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :last_name,
            :first_name,
            :last_name_kana,
            :first_name_kana,
            :postcode,
            :address,
  presence: true
  validates :is_deleted, inclusion: { in: [true, false] }
  validates :postcode, format: {with: /\A\d{7}\z/}, presence: true
  validates :phone_number, format: {with: /\A0\d{10,11}\z/}, presence: true
  
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  
  def full_name
    self.last_name + " " + self.first_name
  end

  def full_name_kana
    self.last_name_kana + " " + self.first_name_kana
  end
  
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
  def customer_status
    if is_deleted == true
      "退会"
    else
      "有効"
    end
  end
end
