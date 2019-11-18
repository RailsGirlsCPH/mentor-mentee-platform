class ApplicationController < ActionController::API 
  #protect_from_forgery with: :exception
  include Response
  include ExceptionHandler

  def set_default_request_format
    request.format = :json
  end
  before_action :set_default_request_format
end

