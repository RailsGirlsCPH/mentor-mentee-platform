class Api::V1::MeetingintervalsController < ApplicationController
  before_action :set_meetinginterval, only: [:show, :update, :destroy]

  #GET /meetingintervals
  def index
    @meetingintervals = Meetinginterval.all
    json_response(@meetingintervals)
  end

  #POST /meetingintervals
  def create
    @meetinginterval = Meetinginterval.create!(meetinginterval_params)
    json_response(@meetinginterval, :created)
  end

  #GET /meetingintervals/:id
  def show
    json_response(@meetinginterval)
  end

  #PUT /meetingintervals/:id
  def update
    @meetinginterval.update(meetinginterval_params)
    head :no_content
  end

  #DELETE /meetingintervals/:id
  def destroy
    @meetinginterval.destroy
    head :no_content
  end

  private
  def meetinginterval_params
    params.permit(:interval)
  end

  def set_meetinginterval
    @meetinginterval = Meetinginterval.find(params[:id])
  end
end
