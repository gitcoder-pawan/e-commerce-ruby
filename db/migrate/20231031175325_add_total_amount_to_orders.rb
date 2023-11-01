class AddTotalAmountToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :total_amount, :integer
  end
end
