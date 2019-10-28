require "test_helper"

describe ReviewsController do
  
  let (:product) {
    products(:magician)
  }
  
  let (:review) {
    reviews(:one)
  }

  describe "create" do
    
    describe "while not logged in" do
      
      it "guest can create a review with valid data and is redirected to product page" do
        
        review_hash = {
          review: {
            rating: 2, 
            text: "Not very good at all",
            product_id: product.id,
          }
        }
     
        expect {
          post product_reviews_path(product.id), params: review_hash
        }.must_differ "Review.count", 1
       
    
        must_respond_with :redirect
        must_redirect_to  product_path(product.id)

      end

      it "review cannot be created with invalid data" do
      
        invalid_rating_hash = {
          review: {
            rating: 11, 
            text: "Really really awesome",
            product_id: product.id,
          }
        }

        invalid_id_hash = {
          review: {
            rating: 2, 
            text: "Not very good at all",
            product_id: -5,
          }
        }

        expect {
          post product_reviews_path(product.id), params: invalid_rating_hash
        }.wont_change "Review.count"

        # expect {
        #   post product_reviews_path(-5), params: invalid_id_hash
        # }.must_differ "Review.count", 0

        assert_template :new

      end
      
    end
    
    describe "while logged in" do
      
      it "merchant can't add a review for their own product" do 
        
      end
      
    end
    
  end
  
  describe "new" do
    it "loads the review form" do

      get new_product_review_path(product.id)
      must_respond_with :success
    end
    
  end

end