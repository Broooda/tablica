class RaportController < ApplicationController
	def index

	end

end

private
def find_by_day
	hours_in_that_day.to_a = HoursPlan.where(
	'user_id = ? and start_date > ? and start_date < ?',
	default_work_time.user_id,@start_date.to_date,@end_date.to_date
	)
end

def count_work_hours

end
