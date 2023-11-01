class CreateOrder < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :account
      t.string :status # status -> cancel, confirmed, delivered
      t.timestamps
    end
  end
end
