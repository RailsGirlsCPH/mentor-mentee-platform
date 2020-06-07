class Api::V1::ProfilesController < ApplicationController
  #application_controller.rb contains before action for all controllers
  #these are :authorize_request, and defines current user.

  #GET /profile/
  def show # index
    @current_user = current_user
  end

  # PUT /profile/
  def update
    @current_user = current_user
    @current_user.update!(api_user_params)
  end

  # DELETE /profile/
  def destroy
    @current_user.destroy
  end

  private
  def api_user_params
    params.permit(:first_name, :last_name, :city, :email, :username, :mentor, :mentee, :password, :password_confirmation)
  end

end
