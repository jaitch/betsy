# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

<<<<<<< HEAD
MERCHANT_FILE = Rails.root.join('db', 'merchants-seeds.csv')
CATEGORY_FILE = Rails.root.join('db', 'categories-seeds.csv')
PRODUCT_FILE = Rails.root.join('db', 'products-seeds.csv')
=======
MERCHANT_FILE = Rails.root.join('db', 'seed_data', 'merchants-seeds.csv')
CATEGORY_FILE = Rails.root.join('db', 'seed_data', 'categories-seeds.csv')
PRODUCT_FILE = Rails.root.join('db', 'seed_data', 'products.csv')
ORDERPRODUCT_FILE = Rails.root.join('db', 'seed_data', 'orderproducts-seeds.csv')
ORDER_FILE = Rails.root.join('db', 'seed_data', 'orders-seeds.csv')
>>>>>>> c678959836cb7f9a16732078517b1a633764479d

puts "Loading raw media data from #{MERCHANT_FILE}"

merchants_failures = []

CSV.foreach(MERCHANT_FILE, :headers => true) do |row|
  merchant = Merchant.new
  merchant.username = row['username']
  merchant.email = row['email']
<<<<<<< HEAD
  successful = merchant.save
  
=======
  merchant.uid = row['uid']
  merchant.provider = row['provider']
  successful = merchant.save

>>>>>>> c678959836cb7f9a16732078517b1a633764479d
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
<<<<<<< HEAD
  
  if !successful
    category_failures << category
    puts "Failed to save merchant: #{category.errors.inspect}"
  else
    puts "Created merchant: #{category.inspect}"
=======

  if !successful
    categories_failures << category
    puts "Failed to save category: #{category.errors.inspect}"
  else
    puts "Created category: #{category.inspect}"
>>>>>>> c678959836cb7f9a16732078517b1a633764479d
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
<<<<<<< HEAD
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

=======
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


  puts "Loading raw media data from #{ORDER_FILE}"

  orders_failures = []

  CSV.foreach(ORDER_FILE, :headers => true) do |row|
    order = Order.new
    order.name = row['order']
    successful = order.save

    if !successful
      orders_failures << order
      puts "Failed to save order: #{order.errors.inspect}"
    else
      puts "Created order: #{order.inspect}"
    end
  end

  orderproducts_failures = []

  CSV.foreach(ORDERPRODUCT_FILE, :headers => true) do |row|
    orderproduct = Orderproduct.new
    orderproduct.quantity = row['quantity']
    orderproduct.order_id = row['order_id']
    orderproduct.product_id = row['product_id']
    successful = orderproduct.save

    if !successful
      orderproducts_failures << orderproduct
      puts "Failed to save orderproduct: #{orderproduct.errors.inspect}"
    else
      puts "Created orderproduct: #{orderproduct.inspect}"
    end
  end


end
>>>>>>> c678959836cb7f9a16732078517b1a633764479d
