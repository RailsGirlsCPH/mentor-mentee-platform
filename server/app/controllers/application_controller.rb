class ApplicationController < ActionController::API 
  #protect_from_forgery with: :exception
  include Response
  include ExceptionHandler
end

