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
