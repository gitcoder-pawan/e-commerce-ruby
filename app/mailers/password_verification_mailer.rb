class PasswordVerificationMailer < ApplicationMailer
    def verification_email(user, code)
        @code = code
        @user = user
        mail(to: @user.email, subject: 'Reset password')
    end
end
