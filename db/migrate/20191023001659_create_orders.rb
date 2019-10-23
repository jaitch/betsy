class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.state :string 
      t.name :string 
      t.email :string 
      t.mailing_address :string 
      t.zip :int 
      t.name_on_cc :string 
      t.cc_number :int 
      t.cc_cvc :int 
      t.cc_exp :string
      
      t.timestamps
    end
  end
end
