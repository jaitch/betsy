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


end
