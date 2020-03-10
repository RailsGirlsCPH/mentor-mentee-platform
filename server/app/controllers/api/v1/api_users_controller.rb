class Api::V1::ApiUsersController < ApplicationController
  before_action :set_api_user, only: [:show, :update, :destroy]
  skip_before_action :authorize_request, only: :create

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
    auth_token = AuthenticateUser.new(@api_user.email, @api_user.password).call
    response = { message: Message.account_created, auth_token: auth_token, api_user: @api_user }
    json_response(response, :created)
    #json_response(@api_user, :created)
  end

  # GET /api_users/:id
  def show
    #json_response(current_user)
    json_response(@api_user)
  end

  # PUT /api_users/:id
  def update
    @api_user.update!(api_user_params)
    head :no_content
  end

  # DELETE /api_users/:id
  def destroy
    @api_user.destroy
    head :no_content
  end

  private

  def api_user_params

    params.permit(:first_name, :last_name, :city, :email, :username, :mentor, :mentee, :password, :password_confirmation)
  end

  def set_api_user
    if params[:id] == 'myuser'
      @api_user = current_user
    else
      @api_user = ApiUser.find(params[:id])
    end
  end

end
