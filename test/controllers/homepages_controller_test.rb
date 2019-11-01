require "test_helper"

describe HomepagesController do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  
  it "@products lists all products" do
    expect(Product.all.count).must_equal @products.count
  end
  
  it "@merchants lists all products" do
    
  end
  
  it "@categories lists all products" do
    
  end
  
  
end
