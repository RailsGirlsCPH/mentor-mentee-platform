require 'pry'
class SessionsController < Devise::SessionsController
  # skip_before_action :verify_authenticity_token, if: :json_request?, raise: false

  acts_as_token_authentication_handler_for ApiUser
  # skip_before_filter :verify_authenticity_token, only: [ :create]
  # skip_filter :verify_signed_out_user, only: [:destroy]
  respond_to :json
  # skip_before_action :authenticate_entity_from_token!
  # skip_before_action :authenticate_entity!
  before_action :authenticate_entity_from_token!, :only => [:destroy]
  # before_action :authenticate_entity!, :only => [:destroy]

  def create
    @current_user = ApiUser.find_by(email: params[:email])
    if @current_user == nil
      render json: Message.user_not_found.as_json(), :status => :unauthorized
    elsif @current_user.valid_password?(params[:password])
    else
      render json: Message.incorrect_password.as_json(), :status => :unauthorized
    end

  end

  def delete #destroy #I have decided not to use the built in destroy methods as it seems to have methods like 'respond_to_on_destroy and 'verify_signed_out_user' which aren't included in API only rails
    if @current_user = ApiUser.find_by(authentication_token: params[request.headers['Authorization']]) == nil
      render json: Message.invalid_credentials.as_json(), :status => :unauthorized
    else
      @current_user = ApiUser.find_by(authentication_token: params[request.headers['Authorization']])
      @current_user.authentication_token = nil
    end
  end

  private

  def json_request?
    request.format.json?
  end
end
