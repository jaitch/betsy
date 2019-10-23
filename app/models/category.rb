class Category < ApplicationRecord
  belongs_to_and_has_many :products
  
  validates :name, presence: true
end
