require "test_helper"

describe ApplicationHelper, :helper do
  describe 'merchant drop-down' do
    it "lists the merchants in a drop-down" do 
    #test if: nav bar contains the things you expect it to contain, when there are many vs. 1 vs. 0
    # the link is there, the name matches

      # Arrange 
      all_merchants = Merchant.all 

      # Act
      merch_drop_down = merchants_dropdown
    
      # Assert
      expect(merch_drop_down).must_be_kind_of String
      all_merchants.each do |merchant|
        expect(merch_drop_down).must_include(merchant.username)
      end
    end 

    it "does something when there are no drop-down options" do 
    end 


  end

  describe 'category drop-down' do
  end
end