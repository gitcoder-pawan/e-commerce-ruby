class AddColumnsToProductSupplierProduct < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :product_type
    add_column :products, :description, :text
    add_column :products, :length, :integer, default: 0
    add_column :products, :breadth, :integer, default: 0
    add_column :products, :height, :integer, default: 0
    add_column :products, :weight, :integer, default: 0
    add_column :products, :category, :string
    add_column :products, :sub_category, :string
    add_column :products, :status, :string

    add_column :supplier_products, :color, :string
    add_column :supplier_products, :brand, :string
    add_column :supplier_products, :quantity, :integer, default: 0

  end
end
