class AddProductType < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :product_type, :string
  end
end
