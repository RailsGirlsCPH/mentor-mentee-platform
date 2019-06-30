class Api::V1::ApiUsersController < ApplicationController
  before_action :set_api_user, only: [:show, :update, :destroy]

  #GET /api_users
  def index
    @api_users = ApiUser.all
    json_response(@api_users)
  end

  # Post /api_users
  def create
    @api_user = ApiUser.create!(api_user_params)
    json_response(@api_user, :created)
  end

  # GET /api_users/:id
  def show
    json_response(@api_user)
  end

  # PUT /api_users/:id
  def update
    @api_user.update(api_user_params)
    head :no_content
  end

  # DELETE /api_users/:id
  def destroy
    @api_user.destroy
    head :no_content
  end

  private

  def api_user_params
    #whitelist params
    #params.permit(:email, :password_digest)
    params.require(:api_user).permit(:email, :password_digest)
  end

  def set_api_user
    @api_user = ApiUser.find(params[:id])
  end
end
