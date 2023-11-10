class PasswordsController < ApplicationController
    def send_passcode
        @account = current_user
        if @account.present?
            send_password_verification_code(@account)
            render json: {message: "Please enter the code the sent to your email!"}
        else
            render json: { error: "Account doesn't exist!"}, status: :unprocessable_entity
        end
    end

    def reset_password
        @account = current_user
        if @account.password_code == permitted_params[:code]
            @account.update(password: permitted_params[:password])
            render json: {message: "Password reset successfully!"}
        else
            render json: {error: "Inorrect code!"}
        end
    end 

    private

    def permitted_params
        params.require(:data).permit(:email, :code, :password)
    end

    def current_user
        Account.find_by_email(permitted_params[:email])
    end

    def send_password_verification_code(account)
        code = random_number = rand(100_000..999_999).to_i
        account.update(password_code: code)
        PasswordVerificationMailer.verification_email(account, code).deliver_now
    end
end