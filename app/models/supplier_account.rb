class SupplierAccount < ApplicationRecord
    belongs_to :account

    AADHAR_FORMAT = /\A\d{12}\z/
    validates :aadhar_number, presence: true, uniqueness: true, format: { with: AADHAR_FORMAT }
    validates :verified, inclusion: { in: [true, false] }
  end
  