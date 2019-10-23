class Merchant < ApplicationRecord
  has_many :products
  
  validates :username, presence: true
  validates :username, uniqueness: true
  
  validates :email, presence: true
  validates :email, uniqueness: true
  
  def self.all_merchants
    joined = Merchant.all.sort_by(&:created_at).reverse
    return joined
  end
end
