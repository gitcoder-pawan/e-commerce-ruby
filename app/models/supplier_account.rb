class SupplierAccount < ApplicationRecord
    belongs_to :account
    has_many :supplier_products
    has_many :products, through: :supplier_products

    AADHAR_FORMAT = /\A\d{12}\z/
    validates :aadhar_number, presence: true, uniqueness: true, format: { with: AADHAR_FORMAT }
    validates :verified, inclusion: { in: [true, false] }
  end
  