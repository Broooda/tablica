class ScrumMeetingsController < ApplicationController

  layout false, only: [:show]

  def index; end

  def show
    @meetings = []

    start_date = DateTime.strptime(params[:start_date], '%Y-%m-%d')
    count = params[:count].to_i
    case params[:period]
    when 'day'
      period = 1
    when 'week'
      period = 7
    when 'month'
      period = 30
    end

    counter = 0
    while counter < count
      from = start_date + counter*period
      to =   start_date + (counter+1)*period
      meeting = HoursPlan.most_people_at_the_same_time(from, to)
      meeting[:start_date] = from
      @meetings << meeting
      
      counter += 1
    end
  end

end