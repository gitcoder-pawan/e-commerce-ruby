class CreateSupplierProduct < ActiveRecord::Migration[7.1]
  def change
    create_table :supplier_products do |t|
      t.references :product
      t.references :supplier
      t.timestamps
    end
  end
end
