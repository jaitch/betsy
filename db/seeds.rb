# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

MERCHANT_FILE = Rails.root.join('db', 'seed_data', 'merchants-seeds.csv')
CATEGORY_FILE = Rails.root.join('db', 'seed_data', 'categories-seeds.csv')
PRODUCT_FILE = Rails.root.join('db', 'seed_data', 'products.csv')

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

CSV.foreach(CATEGORY_FILE, :headers => true) do |row|
  category = Category.new
  category.name = row['name']
  successful = category.save
  
  if !successful
    categories_failures << category
    puts "Failed to save category: #{category.errors.inspect}"
  else
    puts "Created category: #{category.inspect}"
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
  product.photo = row['photo']
  product.retire = row['retire']
  product.merchant_id = row['merchant_id']
  successful = product.save
  
  if !successful
    products_failures << product
    puts "Failed to save product: #{product.errors.inspect}"
  else
    puts "Created product: #{product.inspect}"
  end
end