class Api::V1::ProgramminglanguagesController < ApplicationController

  before_action :set_programminglanguage, only: [:show, :update, :destroy]

  #GET /programminglanguages
  def index
    @programminglanguages = Programminglanguage.all
    json_response(@programminglanguages)
  end

  #POST /programminglanguages
  def create
    @programminglanguage = Programminglanguage.create!(programminglanguage_params)
    json_response(@programminglanguage, :created)
  end

  #GET /programminglanguages/:id
  def show
    json_response(@programminglanguage)
  end

  #PUT /programminglanguages/:id
  def update
    @programminglanguage.update(programminglanguage_params)
    head :no_content
  end

  #DELETE /programminglanguages/:id
  def destroy
    @programminglanguage.destroy
    head :no_content
  end

  private
  def programminglanguage_params
    params.permit(:language)
  end

  def set_programminglanguage
    @programminglanguage = Programminglanguage.find(params[:id])
  end
end
