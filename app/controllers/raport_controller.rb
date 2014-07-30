class RaportController < ApplicationController
	def index
	end

def take_day

end

	def count_day_of_work
		TimeDifference.between(start_time, end_time).in_general
	end

 

end