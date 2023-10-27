module JwtService

  ERROR_CLASSES = [
    JWT::DecodeError,
    JWT::ExpiredSignature,
  ].freeze

  SECRET_KEY = Rails.application.secret_key_base

  def self.encode(payload, expiration = 7.day.from_now)
    payload[:exp] = expiration.to_i
    JWT.encode(payload,SECRET_KEY, 'HS512')
  end

  def authenticate
    token = request.headers[:token] || params[:token]
    if token
      begin
        decoded_token = JWT.decode(token, SECRET_KEY , true, algorithm: 'HS256')
        @current_user = Account.find(decoded_token[0]['id'])
      rescue *ERROR_CLASSES => exception
        handle_exception exception
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
  