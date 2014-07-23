class WeekController < ApplicationController
  
  layout 'nocontainer' 

  def showtime #wyswietla kalendarz
    @start_hour = 9
    @end_hour = 22
  end

  def showpeople
    @users = User.all
  end

end