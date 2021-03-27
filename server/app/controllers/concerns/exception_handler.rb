module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end

  class MissingToken < StandardError; end

  class InvalidToken < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ActiveRecord::RecordNotFound, with: :four_o_four
    rescue_from ActionController::ParameterMissing, with: :four_twenty_two
    # Following handlers not required until authentication set up
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two

    rescue_from ActiveRecord::RecordNotFound do |error_response|
      json_response({ message: error_response.message }, :not_found)
    end
  end

  private

  def four_o_four(error_response)
    json_response({ message: error_response.message }, :not_found)
  end

  def four_twenty_two(error_response)
    json_response({ message: error_response.message }, :unprocessable_entity)
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(error_response)
    json_response({ message: error_response.message }, :unauthorized)
  end
end
