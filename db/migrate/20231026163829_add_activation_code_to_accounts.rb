class AddActivationCodeToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :activation_code, :integer
  end
end
