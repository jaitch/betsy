class Order < ApplicationRecord
  has_many :orderproduct
  has_many :products, through: :orderproduct
end
