class Order < ApplicationRecord
  has_many :orderproducts
  has_many :products, through: :orderproducts # dependent: nullify
#  validates :password, presence: true, unless: Proc.new { |a| a.password.blank? }
end
