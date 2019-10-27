require "test_helper"

describe Review do
  
  let (:product) {
    products(:magician)
  }
  
  let (:review) {
    reviews(:one)
  }
  
  it "can be instantiated" do
    
    review = Review.create(rating: 4, product_id: product.id, text: "So great")
    
    expect(review.valid?).must_equal true
    
  end
  
  it "will have the required field" do
    refute_nil(review[:rating])
  end
  
  describe "relationships" do 
    it 'can access the product through "review"' do
      
      review = Review.create(rating: 2, product_id: product.id, text: "Just okay")

      expect _(review.product_id).must_equal product.id
      
    end
    
    it 'can set the product ID through "review"' do
      
      review = Review.create(rating: 4, product_id: product.id, text: "So great")
      
      product_2 = products(:batman)
      
      review.product_id = product_2.id
      
      expect _(review.product_id).must_equal product_2.id
      
    end
  end
  
  describe "validations" do
    
    it "must have a rating" do
      
      no_rating = Review.new(rating: nil, product_id: product.id, text: "")
      
      expect(no_rating.valid?).must_equal false
      expect(no_rating.errors.messages).must_include :rating
      
    end
    
    it "ratings that are integers 1 through 5 are valid" do
      
      expect(review.rating).must_be_kind_of Integer
      assert(review.rating.between?(1,5))
      
    end
    
    it "ratings that are not 1 through 5 are invalid" do 
      
      invalid_rating_1 = Review.new(rating: 0, product_id: product.id, text: "")
      invalid_rating_2 = Review.new(rating: 3.5, product_id: product.id, text: "")
      invalid_rating_3 = Review.new(rating: 6, product_id: product.id, text: "")
      
      expect(invalid_rating_1.valid?).must_equal false
      expect(invalid_rating_2.valid?).must_equal false
      expect(invalid_rating_3.valid?).must_equal false
      
      expect(invalid_rating_1.errors.messages).must_include :rating
      expect(invalid_rating_2.errors.messages).must_include :rating
      expect(invalid_rating_3.errors.messages).must_include :rating
      
      
    end
    
  end
  
  describe "custom methods" do
    
  end
  
end
