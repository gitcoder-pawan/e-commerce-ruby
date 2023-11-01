class Address < ApplicationRecord
    belongs_to :account
    validates :pincode, presence: true, format: { with: /\A\d{6}\z/, message: "should be a 6-digit number" }
end
  