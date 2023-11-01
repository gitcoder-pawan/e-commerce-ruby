class AddTokenVersionToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :token_version, :integer, default: 0 
  end
end
