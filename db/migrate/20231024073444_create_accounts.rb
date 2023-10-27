class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date :date_of_birth
      t.string :gender
      t.integer :contact_number
      t.string :email
      t.string :password
      t.boolean :activated
      t.string :type

      t.timestamps
    end
  end
end
