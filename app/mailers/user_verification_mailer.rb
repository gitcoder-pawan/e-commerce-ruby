class UserVerificationMailer < ApplicationMailer
    def verification_email(user, code)
        @code = code
        @user = user
        mail(to: @user.email, subject: 'Account activation')
    end
end
