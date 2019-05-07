class MeetingfreqsController < ApplicationController
  def index
    @meetingfreqs = Meetingfreq.all
    respond_to :html, :json
  end
  def show
    @meetingfreq = Meetingfreq.find(params[:id])
  end

  def new
  end
  def edit
    @meetingfreq = Meetingfreq.find(params[:id])
  end
  def create
    @meetingfreq = Meetingfreq.new(meetingfreq_params)
    if @meetingfreq.save
      redirect_to @meetingfreq
    else
      render 'new'
    end
  end
  def destroy
    @meetingfreq = Meetingfreq.find(params[:id])
    @meetingfreq.destroy
    redirect_to meetingfreqs_path
  end
  private
  def meetingfreq_params
    params.require(:meetingfreq).permit(:interval)
  end

end

