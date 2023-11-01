class Order < ApplicationRecord
    belongs_to : account_id
    has_many :order_supplier_products
    has_many :supplier_products, through: :order_supplier_products

    validates :status, :total_amount, presence: true
end