class CreateSupplierAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :supplier_accounts do |t|
      t.string :aadhar_number
      t.boolean :verified
      t.references :account
      t.timestamps
    end
  end
end
