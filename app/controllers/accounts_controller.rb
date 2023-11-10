class AccountsController < ApplicationController
    # JwtService > authenticate included in application controller
    before_action :authenticate, except: [:create, :verify_code, :resend_code]

    def create
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
      @account = Account.find_by_email(permitted_params[:email])

      unless @account.present?
        return render json: {error: "Account not found!"}
      end
      if @account.activation_code == permitted_params[:code].to_i
        @account.update(activated:true)
        render json: {message: "Account activated sucessfully"}
      else
        return render json: { error: "Invalid activation code"}, status: :unprocessable_entity
      end
    end

    def resend_code
      @account = Account.find_by_email(permitted_params[:email])
      send_email_verification_code(@account)
      render json: { message: "Code sent on #{@account.email}"}
    end

    def update
      render json: {message: 'Update Successfully!', data: @current_user}
    end

    def supplier_account 
      @supplier_account = SupplierAccount.new(permitted_params.merge({account_id: @current_user.id}))

      if @supplier_account.save 
        render json: {message: "Supplier Account created successfully!", data: @supplier_account}, status: :created
      else
        render json: {error: @supplier_account.errors.full_messages}, status: :unprocessable_entity
      end
    end 
    
    private

    def permitted_params 
      params.require(:data).permit(:first_name, :middle_name, :last_name, :date_of_birth, :gender, :contact_number, :email, :password, :activated, :token, :code, :aadhar_number, :verified)
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