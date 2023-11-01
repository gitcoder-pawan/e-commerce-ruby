class CreateRatingFeedback < ActiveRecord::Migration[7.1]
  def change
    create_table :rating_feedbacks do |t|
      t.integer :rating
      t.string :feedback 
      t.references :account
      t.references :supplier_product
      t.timestamps
    end
  end
end
