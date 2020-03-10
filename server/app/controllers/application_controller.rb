class ApplicationController < ActionController::API 
  #protect_from_forgery with: :exception
  include Response
  include ExceptionHandler

  before_action :authorize_request
  attr_reader :current_user

  def set_default_request_format
    request.format = :json
  end
  before_action :set_default_request_format

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end

