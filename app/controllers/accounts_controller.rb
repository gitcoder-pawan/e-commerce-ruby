class AccountsController < ApplicationController
    def signup
        permitted_params[:email] = permitted_params[:email].downcase
        @account = Account.new(permitted_params)
        if @account.save
          send_email_verification_code(@account)
          render json: { message: 'Account created successfully!' }, status: :created
        else
          render json: { errors: @account.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def verify_code
      @account = current_user
      if @account.activation_code == permitted_params[:code]
        @account.update(activated:true)
        render json: {message: "Account activated sucessfully"}
      else
        return render json: { error: "Invalid activation code"}, status: :unprocessable_entity
      end
    end

    def resend_code
      @account = current_user
      send_email_verification_code(@account)
    end
    
    private

    def permitted_params
      params.require(:data).permit(:first_name, :middle_name, :last_name, :date_of_birth, :gender, :contact_number, :email, :password, :activated, :token, :code)
    end

    def current_user
      Account.find_by_email(permitted_params[:email])
    end

    def send_email_verification_code(account)
        code = random_number = rand(100_000..999_999).to_i
        account.update(activation_code: code)
        UserVerificationMailer.verification_email(account, code).deliver_now
    end

end