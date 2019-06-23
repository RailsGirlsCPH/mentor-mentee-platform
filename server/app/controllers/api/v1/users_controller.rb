class Api::V1::UsersController < ApplicationController
  #skip_before_action :verify_authenticity_token
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: {users: @users}
  end

  def show
    @user = User.find(params[:id])
    render json: {user: @user}
  end

  def new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params[:user])
    if @user.save
      render json: @user, status: :created, location: api_v1_user_url(@user)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  def update
    if @user.update(user_params[:user])
      render json: @user, status: :ok, location: api_v1_user_url(@user)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end
  private

  def user_params
    params.require(:user)
    params.permit(user: [:id, :first_name, :last_name, :city, :email, :mentor, :mentee ])
    
  end
end
