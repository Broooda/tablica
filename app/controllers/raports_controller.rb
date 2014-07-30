class RaportsController < ApplicationController
  
	def index
	end

	def take_day
		  work_days = HoursPlan.where(
		 	  'user_id = ? and start_date > ? and start_date < ?',
		 	  current_user.id,params[:start],(params[:end].to_time+1.day)
		  )
		  holiday_days = HolidaysPlan.where(
		  	'user_id = ? and holiday_date > ? and holiday_date < ?',
		  	current_user.id,(params[:start].to_time),(params[:end].to_time+1.day)
		  )
		  
		  work_minutes=0
		  holiday_minutes=0

		  work_days.each do |work_day|
		  	work_minutes+=TimeDifference.between(work_day.end_date, work_day.start_date).in_minutes
		  end

		  holiday_days.each do |holiday_day|
		  	holiday_minutes+=holiday_day.hours
		  end

		  work_hours=(work_minutes/60).to_i
		  holiday_hours=(holiday_minutes/60).to_i

		  work_minutes=(work_minutes-work_hours*60).to_i
		  holiday_minutes=(holiday_minutes-holiday_hours*60).to_i

		  work_hours=work_hours.to_s+" hours and "+work_minutes.to_s+" minutes"
		  holiday_hours=holiday_hours.to_s+" hours and "+holiday_minutes.to_s+" minutes"

		  redirect_to root_url
	end
end