class RaportController < ApplicationController
  def index
  end

def take_day
  take_day = HoursPlan.where(
  'user_id = ? and start_date > ? and start_date < ?',
  currentuser_id,zmienna_ktora_ma_poczatek_daty,  zmienna_ktora_ma_koniec_daty
  )
end

  def count_day_of_work
    TimeDifference.between(start_time, end_time).in_general
  end

 

end