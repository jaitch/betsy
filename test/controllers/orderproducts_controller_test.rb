require "test_helper"

describe OrderproductsController do
  # describe 'index' do
  #   it "responds with success when there are many orderproducts saved" do
  #     op1 = orderproducts(:op1)
  #     op2 = orderproducts(:op2)
  #     op3 = orderproducts(:op3)
  #     get orderproducts_path
  #     must_respond_with :success
  #   end
  #   it "responds with success when there are no orderproducts saved" do
  #     orderproduct = orderproducts(:op1)
  #     delete orderproduct_path(orderproduct)
  #     get orderproduct_path(orderproduct.id)
  #     get orderproducts_path
  #     must_respond_with :success
  #   end
  # end
  # describe 'show' do
  #   it 'responds with success when showing an existing valid orderproduct' do
  #     op = orderproducts(:op1)
  #     if Orderproduct.count != 1
  #       puts "No orderproduct saved."
  #     end
  #     get orderproduct_path(op.id)
  #     must_respond_with :success
  #   end
  #   it 'responds with 404 when given an invalid orderproduct id' do
  #   end
  # end

  describe 'create' do
    it 'can create a new orderproduct with valid information' do
      product_id = products(:clown).id
      expect { post product_orderproducts_path(product_id) }.must_differ 'Orderproduct.count', 1
    end
    it 'does not create an orderproduct if the product is out of stock' do
      product = products(:magician)
      product.stock = 0
      expect { post product_orderproducts_path(product.id) }.wont_change 'Orderproduct.count'
      must_respond_with :failure
      must_redirect_to products_path
    end

    it 'does not create an orderproduct if the product id is invalid' do
      expect{ post product_orderproducts_path('-63') }.wont_change 'Orderproduct.count'
      must_respond_with 404
    end

    it 'uses the session order id for the orderproduct order id if the is in an existing order / can add a product to an order that does not yet contain it, and creates a new orderproduct in the process' do
      product_id = products(:clown).id
      post product_orderproducts_path(product_id)
      num_orders = Order.count
      order = Order.last
      num_ops = order.orderproducts.count
      second_product = products(:taco)
      post product_orderproducts_path(second_product.id)
      # a new Order isn't created
      expect(Order.count).must_equal num_orders
      # there is another orderproduct within the order
      expect(order.orderproducts.count).must_equal num_ops + 1
    end

    it 'does not let buyer add product to the cart if cart contains full stock of a product' do
      product = products(:magician)
      product.stock = 1
      post product_orderproducts_path(product.id)
      post product_orderproducts_path(product.id)
      must_respond_with 302
      must_redirect_to products_path
    end

    it 'can add product to cart that already contains that item if not yet maxed out, and increases quantity by one' do
      product_id = products(:batman).id
      post product_orderproducts_path(product_id)
      order = Order.last
      second_product = products(:batman)
      post product_orderproducts_path(second_product.id)
      op = order.orderproducts.last
      expect(op.quantity).must_equal 2
    end
  end

  describe 'update orderproduct quantity' do
    it 'can change the quantity of an orderproduct in an order and save it' do
      product = products(:clown)
      post product_orderproducts_path(product.id)
      order = Order.last
      op = order.orderproducts.last
      orderproduct_hash = {
      orderproduct: {
      quantity: 5
      }}
      expect{ patch orderproduct_path(op), params: orderproduct_hash }.wont_change Orderproduct.count
      must_respond_with :redirect
      expect(op.quantity).must_equal 5
    end
  end
end
