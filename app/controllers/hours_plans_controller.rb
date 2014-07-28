class HoursPlansController < ApplicationController
  
  layout false

  def edit
    @hours_plan = HoursPlan.find(params[:id])
  end

  def update
    @hours_plan = HoursPlan.find(params[:id])

    @hours_plan.start_date = @hours_plan.start_date.strftime("%Y-%-m-%-d ") + params[:start_hour]
    @hours_plan.end_date = @hours_plan.end_date.strftime("%Y-%-m-%-d ") + params[:end_hour]

    @hours_plan.over_hours = params[:over_hours]

    if @hours_plan.save
      redirect_to week_time_url, notice: "Edited"
    else
      redirect_to week_time_url, notice: "Error while saving"
    end

  end

  
end