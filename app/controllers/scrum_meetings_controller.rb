class ScrumMeetingsController < ApplicationController

  layout false, only: [:show]

  def index; end

  def show
    @meetings = []
    @active_user_number = User.active.size

    start_date = DateTime.strptime(params[:start_date], '%Y-%m-%d')
    case params[:period]
    when 'day'
      period = 1
    when 'week'
      period = 7
    when 'month'
      period = 30
    end

    counter = 0
    while counter < 5
      from = start_date + counter*period
      to =   start_date + (counter+1)*period
      meeting = HoursPlan.most_people_at_the_same_time(from, to)
      meeting[:start_date] = from
      holidays_at_this_time = Holiday.accepted.where("startdate <= :time and enddate >= :time", {time: meeting[:time]})
      meeting[:people_at_holidays] = []
      holidays_at_this_time.each do |holiday|
        meeting[:people_at_holidays] << holiday.user
      end
      @meetings << meeting
      
      counter += 1
    end
  end

end