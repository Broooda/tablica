class HoursPlansController < ApplicationController
  
  before_action :is_mine
  layout false

  def index
    @hours_plans = HoursPlan.all
  end

  def show
    @hours_plan=HoursPlan.find(params[:id])
  end

  def edit
    @hours_plan = HoursPlan.find(params[:id])
  end

  def update
    @hours_plan = HoursPlan.find(params[:id])

    #@hours_plan.start_date = @hours_plan.start_date.strftime("%Y-%-m-%-d ") + params[:start_hour]
    #@hours_plan.end_date = @hours_plan.end_date.strftime("%Y-%-m-%-d ") + params[:end_hour]

    @hours_plan.over_hours = params[:over_hours]

    if @hours_plan.save
      redirect_to week_time_url, notice: "Edited"
    else
      redirect_to week_time_url, notice: "Error while saving"
    end

  end

  def earliest_hoursplan

    now=DateTime.now
    @hours_plan = HoursPlan.where('user_id = :user_id and start_date > :now',{user_id: params[:id], now: now}).order(:startdate).first
    #pobrac wszystkie rozpoczecia przeze mnie i usera
    #iterowac po nich i spr w kazdej czy jestesmy oboje w pracy
    #dopoki nie znajde wspolnego
    #or zamiast and
    #@commonhours =  = HoursPlan.where('user_id = :user_id and startdate > :now',{user_id: params[:id], now: now}).order(:startdate).first
  end

  private
  def is_mine
    @hours_plan = HoursPlan.find(params[:id])
    unless @hours_plan.user == current_user
       redirect_to week_time_url, notice: "Nope, it's not yours"
    end
  end

  
end