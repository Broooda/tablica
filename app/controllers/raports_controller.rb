class RaportsController < ApplicationController
  
	def index
	end

	def take_day
		  work_days = HoursPlan.where(
		  'user_id = ? and start_date > ? and start_date < ?',
		  current_user.id,params[:start],params[:end]
		  )
		  holiday_day = HolidaysPlan.where(
		  'user_id = ? and holiday_date > ? and holiday_date < ?',
		  current_user.id,params[:start],params[:end]
		  )
	end

end