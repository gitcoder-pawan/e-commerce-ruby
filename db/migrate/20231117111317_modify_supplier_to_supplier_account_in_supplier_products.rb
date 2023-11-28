class ModifySupplierToSupplierAccountInSupplierProducts < ActiveRecord::Migration[7.1]
  def change
    rename_column :supplier_products, :supplier_id, :supplier_account_id
  end
end
