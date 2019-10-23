require "test_helper"

describe Order do
  describe 'validations' do
    it 'can be made with valid input' do
    end
  end
  
  describe 'relations' do
    it 'has products' do
      order = order(:c)
      order.products.length.must_equal 2
    end
  end
  
  
  describe 'custom methods' do
  end
end
