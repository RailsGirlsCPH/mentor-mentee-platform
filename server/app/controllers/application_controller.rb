class ApplicationController < ActionController::API 
  #protect_from_forgery with: :exception
  include Response
  include ExceptionHandler

  def set_default_response_format
    request.format = :json
  end
end

