class LanguagesController < ApplicationController
  def index
    @languages = Language.all
  end
  def show
    @language = Language.find(params[:id])
  end

  def new
  end
  def edit
    @language = Language.find(params[:id])
  end
  def create
    @language = Language.new(language_params)
    if @language.save
      redirect_to @language
    else
      render 'new'
    end
  end
  private
  def language_params
    params.require(:language).permit(:language)
  end
end
