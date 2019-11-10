class Api::V1::ApiUsersController < ApplicationController
  before_action :set_api_user, only: [:show, :update, :destroy]
  before_action :set_default_response_format
  #GET /api_users
  def index
    @api_users = ApiUser.includes(:wishes).all
    @api_users = @api_users.where(mentor: true) if params[:mentor] == 'true'
    @api_users = @api_users.where(mentee: true) if params[:mentee] == 'true'
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
    params.require(:api_user).permit(:first_name, :last_name, :city, :email, :password_digest, :mentor, :mentee)
  end

  def set_api_user
    @api_user = ApiUser.find(params[:id])
  end

end
