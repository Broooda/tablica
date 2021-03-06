class WeekController < ApplicationController
  
  layout 'nocontainer'

  before_action :selectweek
  before_action :gethoursplan

  def showtime
    if @hours_plans.size>0
      @start_hour = @hours_plans.minimum('start_date').strftime("%k").to_i+1
      @end_hour = @hours_plans.maximum('end_date').strftime("%k").to_i+3
    else
      @start_hour = 9
      @end_hour = 15
    end
  end

  def showpeople
    @users = User.where('accepted = true')
  end

  def gethoursplan
    get_from = DateTime.commercial(@year, @week_num, 1,0,0,0,'+2') #od poniedzialek 0:00
    get_to = DateTime.commercial(@year, @week_num, 6,0,0,0,'+2') #do sobota 0:00

    @hours_plans = HoursPlan.where('start_date > :from and start_date < :to', { from: get_from, to: get_to})
  end

  def selectweek
    #sprawdz czy jest jakas data, jesli nie to przekieruj na siebie samego z dzisiejsza data
    # (użyłem tablicy prawdy więc sam warunek może być trochę nieczytelny na pierwszy rzut oka :\ )
    if (params[:fulldate].nil? and params[:year].nil?) or (params[:fulldate].nil? and params[:week].nil?)
      @year = Date.today.year
      @week_num = Date.today.cweek

      if action_name == 'showtime'
        redirect_to week_time_date_url(@year,@week_num)
      else
        redirect_to week_people_date_url(@year,@week_num)
      end
    else 
      #sprawdz czy mozna wygenerowac date, jesli tak to wpisz ja
      begin
        @week = DateTime.commercial(params[:year].to_i,params[:week].to_i,1,0,0,0,'+2')
        @year = params[:year].to_i
        @week_num = params[:week].to_i
      rescue
      end

      begin
        @week = DateTime.strptime(params[:fulldate], '%Y-%m-%d');
        @year = @week.year
        @week_num = @week.cweek
      rescue
      end

      if @week.nil? or @year.nil? or @week_num.nil? #jesli nie dalo sie stworzyc daty
        redirect_to week_time_url # TODO: prawdopodobnie jakis lepszy redirect by sie tu przydal
      end
    end
  end

end