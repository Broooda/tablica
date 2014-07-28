class HoursPlansController < ApplicationController
  
  before_action :is_mine
  layout false

  def index
    @hours_plans = HoursPlan.all
  end

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

  def earliest_hoursplan

    now=Time.now
    @hoursplans = HoursPlan.order(:startdate) #wspolne terminy pracy wybranego usera i zaalogowanego uzytkownika
    @earliest_hour = HoursPlan.order(:startdate).first #najblizszy termin, gdy user bedzie w pracy
    if @hoursplans == now || @hoursplans>now
      @commonhours = HoursPlan.order(:startdate) 
    #else
      #puts "Nie znaleziono najblizszego wspolnego terminu pracy"
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