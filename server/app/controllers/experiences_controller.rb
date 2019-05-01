class ExperiencesController < ApplicationController
  def index
    @experiences = Experience.all
  end

  def show
    @experience = Experience.find(params[:id])

  end

  def create
    @user = User.find(params[:user_id])
    @experience = @user.experiences.create(experience_params)
    redirect_to user_path(@user)
  end

  def edit
    @experience = Experience.find(params[:id])
  end
  def update
    @experience = Experience.find(params[:id])
    
    if @experience.update(experience_params)
      redirect_to @experience
    else
      render 'edit'
    end
  end
  def destroy
    @experience = Experience.find(params[:id])
    @experience.destroy
    
    redirect_to experiences_path
  end

  private
  def experience_params
    params.require(:experience).permit(:field_of_interest, :time_spent, :programminglanguage_id) 
  end
end
