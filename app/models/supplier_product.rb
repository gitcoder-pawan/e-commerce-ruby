class SupplierProduct < ApplicationRecord 
    belongs_to :supplier_account
    belongs_to :product
    has_many :order_supplier_products
    has_many :orders, through: :order_supplier_products
end