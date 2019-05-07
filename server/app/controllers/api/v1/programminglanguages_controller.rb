class Api::V1::ProgramminglanguagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_programminglanguage, only: [:show, :update, :destroy]
  def index
    @programminglanguages = Programminglanguage.all
    render json: @programminglanguages
  end
  def show
    @programminglanguage = Programminglanguage.find(params[:id])
    render json: @programminglanguage
  end

  def new
  end
  def edit
    @programminglanguage = Programminglanguage.find(params[:id])
  end
  def create
    @programminglanguage = Programminglanguage.new(programminglanguage_params)
    if @programminglanguage.save
      render json: @programminglanguage, status: :created, location: api_v1_programminglanguage_url(@programminglanguage)
    else
      render json: @programminglanguage.errors, status: :unprocessable_entity
    end
  end
  def update
    if @programminglanguage.update(programminglanguage_params)
      render json: @programminglanguage
    else
      render json: @programminglanguage.errors, status: :unprocessable_entity
    end
  end
  def set_programminglanguage
    @programminglanguage = Programminglanguage.find(params[:id])
  end
  def destroy
    @programminglanguage = Programminglanguage.find(params[:id])
    @programminglanguage.destroy
  end
  private
  def programminglanguage_params
    params.require(:programminglanguage).permit(:language)
  end
end
