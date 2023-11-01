class CreateOrderSupplierProduct < ActiveRecord::Migration[7.1]
  def change
    create_table :order_supplier_products do |t|
      t.references :order 
      t.references :supplier_product
      t.integer :quantity
      t.timestamps
    end
  end
end
