class AddPasswordCodeToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :password_code, :integer
  end
end
