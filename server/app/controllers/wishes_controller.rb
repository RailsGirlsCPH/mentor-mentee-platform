class WishesController < ApplicationController
  def index
    @wishes = Wish.all
    respond_to :html, :json
  end

  def show
    @wish = Wish.find(params[:id])

  end

  def create
    @user = User.find(params[:user_id])
    @wish = @user.wishes.create(wish_params)
    redirect_to user_path(@user)
  end

  def edit
    @wish = Wish.find(params[:id])
  end
  def update
    @wish = Wish.find(params[:id])
    
    if @wish.update(wish_params)
      redirect_to @wish
    else
      render 'edit'
    end
  end
  def destroy
    @wish = Wish.find(params[:id])
    @wish.destroy
    
    redirect_to wishes_path
  end

  private
  def wish_params
    params.require(:wish).permit(:availability, :available_offline, :available_online, :goal, :programminglanguage_id, :meetingfreq_id)
  end
end
