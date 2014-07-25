class HolidaysController < ApplicationController

	def index
		@holiday= Holiday.all
	end
	
	def show
		@holiday= Holiday.find(params[:id])
	end

	def destroy
		@holiday = Holiday.find(params[:id])
  		  if @holiday.destroy
  		   redirect_to holidays_path alert: "Removed Holiday "
  		else
  			redirect_to holidays_path alert: "Not Removed Holiday "
		end
	end
  	
	def new
		@holiday=Holiday.new
	end

	def create
		@holiday=Holiday.new(holiday_params)
	if @holiday.save
			redirect_to holidays_path notice: "Created Holiday"
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
		redirect_to holidays_path
			else
			render 'edit'
		end
	end

	private
		def holiday_params
		params.require(:holiday).permit(:startdate, :enddate, :description, :status) 
	end

end