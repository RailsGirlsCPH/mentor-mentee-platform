class ApplicationController < ActionController::API # used to say    'Base'
  #protect_from_forgery with: :exception
  include Response
  include ExceptionHandler
end

