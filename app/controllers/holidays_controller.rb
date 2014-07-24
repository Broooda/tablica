class HolidaysController < ApplicationController

	def index
		@holiday= Holiday.all
	end
	
	def show
		@holiday =Holiday.find(params[:id])
	end

	def destroy
		@holiday.find(params[:id])
		@holiday.destroy
		redirect_to root_url, alert: "Removed Holiday "
	end

	def new
		@holiday=Holiday.new
	end

	def create
		@holiday=Holiday.new(holiday_params)
		# @holiday=Holiday.new(:startdate,:enddate,:description,:status,:reason)
	if @holiday.save
			redirect_to root_url notice: "Created Holiday"
		else
			render 'new'
		end
	end


	def edit
		@holiday = Holiday.find(params[:id])
	end

	def update
	@holiday =Holiday.find(params[:id]) 
		if @holiday.update(holiday_params)
		redirect_to root_url
			else
			render 'edit'
		end
	end
  	def show
    	@holiday=Holiday.find(params[:id])
  	end
	private
		def holdiay_params
		params.require(:holiday).permit(:startdate, :enddate, :description, :status, :reason) 
	end

end
	