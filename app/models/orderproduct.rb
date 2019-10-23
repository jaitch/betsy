class Orderproduct < ApplicationRecord
  validates :quantity, presence: true
end
