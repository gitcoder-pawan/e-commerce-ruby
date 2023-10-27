class CreateAddress < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :area
      t.string :post_office
      t.string :police_station
      t.string :city
      t.string :state
      t.string :country
      t.integer :pin_code
      t.string :landmark
      t.references :account, foreign_key: true
      t.timestamps
    end
  end
end
