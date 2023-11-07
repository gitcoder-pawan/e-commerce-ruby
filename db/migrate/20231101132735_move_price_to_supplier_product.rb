class MovePriceToSupplierProduct < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :price
    add_column :supplier_products, :price, :integer
  end
end
