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
    get_from = DateTime.commercial(@year, @week_num, 1) #od poniedzialek polnoc 
    get_to = DateTime.commercial(@year, @week_num, 5) #do piatek polnoc

    @hours_plans = HoursPlan.where("start_date > :from and start_date < :to", { from: get_from, to: get_to})

  end

  def selectweek
    @year = Date.today.year
    @week_num = Date.today.cweek
  end
end