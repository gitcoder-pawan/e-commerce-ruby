class Account < ApplicationRecord
    has_many :addresses, dependent: :destroy
    # has_one :supplier_account, dependent: :destroy
    EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    PASSWORD_FORMAT = /\A
      (?=.*[a-z])           # At least one lowercase letter
      (?=.*[A-Z])           # At least one uppercase letter
      (?=.*\d)              # At least one digit
      (?=.*[!@#\$%^&*])     # At least one special character
      .{8,}                 # Minimum length of 8 characters
    \z/x

    PASSWORD_ERROR_MESSAGE = "must include at least one lowercase letter, one uppercase letter, one digit, one special character, and be at least 8 characters long"
  
    validates :email, presence: true, uniqueness: true, format: { with: EMAIL_FORMAT }
    validates :password, presence: true, format: { with: PASSWORD_FORMAT, message: PASSWORD_ERROR_MESSAGE }
  end
  