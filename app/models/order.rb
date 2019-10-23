class Order < ApplicationRecord
  has_many :orderproducts
  has_many :products, through: :orderproducts # dependent: nullify
end
