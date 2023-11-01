class LoginsController < ApplicationController
    def login 
        @account = current_user

        unless @account.present?
            return render json: {error: "Account doesn't exist."}, status: :unprocessable_entity
        end

        if @account.password != permitted_params[:password]
            return render json: {error: "Email or Password is incorrect."}, status: :unprocessable_entity
        end

        unless @account.activated 
            return render json: {error: "Account not activated!", data: filter_account(@account)}, status: :unprocessable_entity
        end
        token = JwtService.encode(@account)
        data = filter_account(@account)
        data[:supplier] = @account.supplier_account rescue nil
        # data[:addresses] = @account.addresses rescue nil
        render json: {message: 'Login Successfully!', data: data, token: token }
    end

    private

    def permitted_params
        params.require(:data).permit(:email, :password)
    end

    def current_user
        Account.find_by_email(permitted_params[:email].downcase)
    end

    def filter_account(account)
        account.as_json.reject{ |k,v| [:password, :activation_code, :password_code].include?(k) }
    end
end