class ProgramminglanguagesController < ApplicationController
  def index
    @programminglanguages = Programminglanguage.all
  end
  def show
    @programminglanguage = Programminglanguage.find(params[:id])
  end

  def new
  end
  def edit
    @programminglanguage = Programminglanguage.find(params[:id])
  end
  def create
    @programminglanguage = Programminglanguage.new(programminglanguage_params)
    if @programminglanguage.save
      redirect_to @programminglanguage
    else
      render 'new'
    end
  end
  def destroy
    @programminglanguage = Programminglanguage.find(params[:id])
    @programminglanguage.destroy
    
    redirect_to programminglanguages_path
  end
  private
  def programminglanguage_params
    params.require(:programminglanguage).permit(:language)
  end
end
