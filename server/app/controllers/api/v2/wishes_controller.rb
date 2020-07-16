require 'uri'
#require 'pry'
class Api::V1::WishesController < ApplicationController
  before_action :set_api_user
  before_action :set_api_user_wish, only: [:show, :update, :destroy]

  #GET /api_users/:api_user_id/wishes
  def index
    @wishes = @api_user.wishes.includes(:programminglanguage, :meetinginterval) 
    @wishes = @wishes.where(available_offline: true) if params[:available_offline] == 'true'
    @wishes = @wishes.where(available_offline: false) if params[:available_offline] == 'false'
    @wishes = @wishes.where(available_online: true) if params[:available_online] == 'true'
    @wishes = @wishes.where(available_online: false) if params[:available_online] == 'false'

    #Explanation regarding includes: not necessary to link programming languages and meeting interval to Wishes, but it means there is only one call to the database during which it pulls all the information linked  by foreign keys in case it needs it in the future. 
  end

  # Post /api_users/:api_user_id/wishes
  def create
    @wish1 = @api_user.wishes.create!(wish_params)
    json_response(@wish1, :created)
  end

  #GET /api_users/:api_user_id/wishes/:wish_id
  def show
    json_response(@wish)
  end

  # PUT /wishes/:id
  def update
    @wish.update!(wish_params) 
    head :no_content
  end

  # DELETE /wishes/:id
  def destroy
    @wish.destroy!
    head :no_content
  end
  private

  def wish_params
    params.permit(:available_offline, :available_online, :goal, :api_user_id, :id, :programminglanguage_id, :meetinginterval_id, :mentee)
  end

  def set_api_user
    if params[:api_user_id].present?
      @api_user = ApiUser.find(params[:api_user_id])
    else
      authorize_request
      @api_user = current_user
    end
  end

  def set_api_user_wish
    @wish = @api_user.wishes.find_by!(id: params[:id]) if @api_user
  end
end
