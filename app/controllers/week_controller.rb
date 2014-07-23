class WeekController < ApplicationController
  
  layout 'nocontainer' 

  def showtime #wyswietla kalendarz
    selectweek
    gethoursplan

    @start_hour = 9
    @end_hour = 22
  end

  def showpeople
    selectweek
    gethoursplan

    @users = User.all
  end

  def gethoursplan
    get_from = DateTime.commercial(@year, @week_num, 1) #od poniedzialek 0:00
    get_to = DateTime.commercial(@year, @week_num, 6) #do sobota 0:00

    @hours_plans = HoursPlan.where("start_date > :from and start_date < :to", { from: get_from, to: get_to})

  end

  def selectweek
    #sprawdz czy jest jakas data, jesli nie to przekieruj na siebie samego z dzisiejsza data
    if params[:year].nil? or params[:week].nil?
      @year = Date.today.year
      @week_num = Date.today.cweek

      if action_name == 'showtime'
        redirect_to week_time_date_url(@year,@week_num)
      else
        redirect_to week_people_date_url(@year,@week_num)
      end
    end  


    #sprawdz czy mozna wygenerowac date, jesli tak to wpisz ja
    begin
      DateTime.commercial(params[:year].to_i,params[:week].to_i,1)
      @year = params[:year].to_i
      @week_num = params[:week].to_i
    rescue
    end


  end

end