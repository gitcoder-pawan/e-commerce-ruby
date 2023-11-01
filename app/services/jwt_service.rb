module JwtService

  ERROR_CLASSES = [
    JWT::DecodeError,
    JWT::ExpiredSignature,
  ].freeze

  SECRET_KEY = Rails.application.secret_key_base

  def self.encode(user, expiration = 7.day.from_now)
    user.update(token_version: user.token_version + 1)
    payload = {
      id: user.id,
      email: user.email,
      token_version: user.token_version,
      exp: expiration.to_i
    }
    JWT.encode(payload,SECRET_KEY, 'HS512')
    
  end

  def authenticate
    token = request.headers[:token] || params[:token]
    if token
      begin
        decoded_token = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS512')
        @current_user = Account.find(decoded_token[0]['id'])
        if @current_user.token_version != decoded_token[0]['token_version']
          render json: { error: 'Invalid token' }, status: :unauthorized
          return
        end
      rescue *ERROR_CLASSES => exception
        handle_exception(exception)
      end
    else
      render json: { error: 'Token missing' }, status: :unauthorized
    end
  end
  def handle_exception(exception)
    # order matters here
    # JWT::ExpiredSignature appears to be a subclass of JWT::DecodeError
    case exception
    when JWT::ExpiredSignature
      return render json: { errors: [token: 'Token has Expired'] },
        status: :unauthorized
    when JWT::DecodeError
      return render json: { errors: [token: 'Invalid token'] },
        status: :bad_request
    else
      return render json: { errors: [token: 'Unexpected error'] }, status: :internal_server_error
    end
  end
end
  