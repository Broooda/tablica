class WeekController < ApplicationController
  
  layout 'nocontainer' 

  def showtime #wyswietla kalendarz
    selectweek

    @start_hour = 9
    @end_hour = 22
  end

  def showpeople
    selectweek
    
    @users = User.all
  end

  def selectweek
    @year = Date.today.year
    @week_num = Date.today.cweek
  end
end