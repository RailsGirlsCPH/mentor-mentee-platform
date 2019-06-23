# app/auth/authenticate_user.rb
class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  # Service entry point
  def call
    JsonWebToken.encode(user_id: api_user.id) if api_user
  end

  private

  attr_reader :email, :password

  # verify user credentials
  def api_user
    api_user = ApiUser.find_by(email: email)
    return api_user if api_user && api_user.authenticate(password)
    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
