require 'uri'

class Api::V1::ExperiencesController < ApplicationController
  before_action :set_api_user
  before_action :set_api_user_experience, only: [:show, :update, :destroy]

  #GET /api_users/:api_user_id/experiences
  def index
    @experiences = @api_user.experiences.includes(:programminglanguage, :meetinginterval)
    @experiences = @experiences.where(available_offline: true) if params[:available_offline] == 'true'
    @experiences = @experiences.where(available_offline: false) if params[:available_offline] == 'false'
    @experiences = @experiences.where(available_online: true) if params[:available_online] == 'true'
    @experiences = @experiences.where(available_online: false) if params[:available_online] == 'false'

    #Explanation regarding includes: not necessary to link programming languages and meeting interval to Wishes, but it means there is only one call to the database during which it pulls all the information linked  by foreign keys in case it needs it in the future. 
  end

  # Post /api_users/:api_user_id/experiences
  def create
    @experience1 = @api_user.experiences.create!(experience_params)
    json_response(@experience1, :created)
  end

  #GET /api_users/:api_user_id/experiences/:experience_id
  def show
    json_response(@experience)
  end

  # PUT /wishes/:id
  def update
    @experience.update!(experience_params) 
    head :no_content
  end

  # DELETE /wishes/:id
  def destroy
    @experience.destroy!
    head :no_content
  end
  private

  def experience_params
    params.permit(:available_offline, :available_online, :qualification, :api_user_id, :id, :programminglanguage_id, :meetinginterval_id, :mentee)
  end

  def set_api_user
    if params[:api_user_id].present?
      @api_user = ApiUser.find(params[:api_user_id])
    else
      authorize_request
      @api_user = current_user
    end
  end

  def set_api_user_experience
    @experience = @api_user.experiences.find_by!(id: params[:id]) if @api_user
  end

end

