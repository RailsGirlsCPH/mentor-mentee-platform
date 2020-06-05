class Api::V1::ApiUsersController < ApplicationController

  skip_before_action :authorize_request, only: [:create]

  #GET /api_users
  def index
    @api_users = ApiUser.includes(wishes: [:programminglanguage, :meetinginterval], experiences: [:programminglanguage,:meetinginterval]).all
    #Explanation regarding includes: not necessary to link programming languages and meeting interval to ApiUser, but it means there is only one call to the database during which it pulls all the information linked  by foreign keys in case it needs it in the future. 
    @api_users = @api_users.where(mentor: true) if params[:mentor] == 'true'
    @api_users = @api_users.where(mentee: true) if params[:mentee] == 'true'
  end


  # Post /api_users
  def create
    @api_user = ApiUser.create!(api_user_params)
    @auth_token = AuthenticateUser.new(@api_user.email, @api_user.password).call
  end

  # GET /api_users/:id
  def show
    @api_user = ApiUser.find(params[:id])
  end

  private

  def api_user_params
    params.permit(:first_name, :last_name, :city, :email, :username, :mentor, :mentee, :password, :password_confirmation)
  end

end
