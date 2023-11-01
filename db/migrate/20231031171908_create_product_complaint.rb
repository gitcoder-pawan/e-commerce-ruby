class CreateProductComplaint < ActiveRecord::Migration[7.1]
  def change
    create_table :product_complaints do |t|
      t.string :complaint 
      t.references :account
      t.references :supplier_product
      t.timestamps
    end
  end
end
