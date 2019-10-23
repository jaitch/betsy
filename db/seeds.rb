# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

MERCHANT_FILE = Rails.root.join('db', 'merchants-seeds.csv')
CATEGORY_FILE = Rails.root.join('db', 'categories-seeds.csv')
PRODUCT_FILE = Rails.root.join('db', 'products-seeds.csv')

puts "Loading raw media data from #{MERCHANT_FILE}"

merchants_failures = []

CSV.foreach(MERCHANT_FILE, :headers => true) do |row|
  merchant = Merchant.new
  merchant.username = row['username']
  merchant.email = row['email']
  successful = merchant.save
  
  if !successful
    merchants_failures << merchant
    puts "Failed to save merchant: #{merchant.errors.inspect}"
  else
    puts "Created merchant: #{merchant.inspect}"
  end
end


puts "Loading raw media data from #{CATEGORY_FILE}"
categories_failures = []

CSV.foreach(MERCHANT_FILE, :headers => true) do |row|
  category = Category.new
  category.name = row['name']
  successful = category.save
  
  if !successful
    category_failures << category
    puts "Failed to save merchant: #{category.errors.inspect}"
  else
    puts "Created merchant: #{category.inspect}"
  end
end

puts "Loading raw media data from #{PRODUCT_FILE}"

products_failures = []

CSV.foreach(PRODUCT_FILE, :headers => true) do |row|
  product = Product.new
  product.name = row['name']
  product.price = row['price']
  product.stock = row['stock']
  product.description = row['description']
  product.photourl = row['photourl']
  product.retired = row ['retired?']
  successful = product.save
  
  if !successful
    productss_failures << product
    puts "Failed to save product: #{product.errors.inspect}"
  else
    puts "Created merchant: #{product.inspect}"
  end
end

