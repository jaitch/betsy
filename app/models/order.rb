class Order < ApplicationRecord
  has_many :products through :orderproduct
end
