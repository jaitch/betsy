class Order < ApplicationRecord
  has_many :orderproducts
  has_many :products, through: :orderproducts #, dependent: nullify
#  validates :TK, presence: true, unless: Proc.new { |a| a.TK.blank? }
end
