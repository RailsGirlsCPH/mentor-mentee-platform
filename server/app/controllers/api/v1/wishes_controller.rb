class Api::V1::WishesController < ApplicationController
  before_action :set_api_user
  # before_action :set_programminglanguage
  # before_action :set_meetinginterval
  before_action :set_api_user_wish, only: [:show, :update, :destroy]


  #GET /api_users/:api_user_id/wishes
  def index
    json_response(@api_user.wishes)
  end

  # Post /api_users/:api_user_id/wishes
  def create
    @api_user.wishes.create!(wish_params)
    json_response(@api_user, :created)
  end

  #GET /api_users/:api_user_id/wishes/:wish_id
  def show
    json_response(@wish)
  end

  # PUT /wishes/:id
  def update
    @wish.update(wish_params)
    head :no_content
  end

  # DELETE /wishes/:id
  def destroy
    @wish.destroy
    head :no_content
  end
  private

  def wish_params
    params.permit(:available_offline, :available_online, :goal)
  end

  def set_api_user
    @api_user = ApiUser.find(params[:api_user_id])
  end

  def set_api_user_wish
    @wish = @api_user.wishes.find_by!(id: params[:id]) if @api_user
  end

end
