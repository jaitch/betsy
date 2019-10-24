class Product < ApplicationRecord
  belongs_to :merchant
  has_many :reviews
  has_many :orderproducts
  has_and_belongs_to_many :categories
  has_many :orders, through: :orderproducts
  
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than: -1 }
  
  # pending custom methods, waiting on categories and orderproducts models to complete
  # def self.products_by_category
  #   categories = []
  
  #   products = self.all
  
  #   products.each do |product|
  #     if !(categories.include?(product.categories_products))
  #       categories << product
  #     end
  #   end
  
  #   return categories
  # end
  
  # def self.products_by_merchant 
  # end
  
  # def update_inventory(orderproducts)
  #   quanity = orderproducts.quanity 
  #   self.stock = stock - quanity
  #   return quantity 
  # end
  
  
end
