class HoursPlansController < ApplicationController
  
  before_action :is_mine
  layout false

  def edit
    @hours_plan = HoursPlan.find(params[:id])
  end

  def update
    @hours_plan = HoursPlan.find(params[:id])

    @hours_plan.over_hours = params[:over_hours]

    if @hours_plan.save
      redirect_to week_time_url, notice: "Edited"
    else
      redirect_to week_time_url, notice: "Error while saving"
    end

  end

  private
  
  def is_mine
    @hours_plan = HoursPlan.find(params[:id])
    unless @hours_plan.user == current_user
       redirect_to week_time_url, notice: "Nope, it's not yours"
    end
  end

  
end