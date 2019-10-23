class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.int :rating

      t.timestamps
    end
  end
end
