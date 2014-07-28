class HolidaysController < ApplicationController
before_action :make_sure_its_mine, only: [:destroy, :edit, :new, :create, :update]
before_action :make_sure_its_admin, only: [:accept, :reject]
	def index
	@holiday= Holiday.where('user_id=:user_id',{user_id: current_user.id})
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

  	def accept
    @holiday = Holiday.find(params[:id])
    @holiday.status = "accepted"
    @holiday.save
   
    redirect_to inboxs_path, notice: "Holiday accepted"
  end

  def reject
    @holiday = Holiday.find(params[:id])
    @holiday.status = "rejected"
    @holiday.reason = params['description']
    @holiday.save
   
    redirect_to inboxs_path, notice: "Holiday rejected"
  end

	def new
		@holiday=Holiday.new
	end

	def create
		@holiday=Holiday.new(holiday_params)
    @holiday.status="pending"
    @holiday.user_id=current_user.id
    @holiday.startdate = params[:startdate] +" "+ params[:starttime]
    @holiday.enddate = params[:enddate] +" " + params[:endtime]
    @holiday.description = params[:description]
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
  @holiday.startdate = params[:startdate] +" "+ params[:starttime]
  @holiday.enddate = params[:enddate] +" " + params[:endtime]
  @holiday.description = params[:description]
		if @holiday.save
		redirect_to holidays_path notice: "Edited Holiday"
			else
			render 'edit'
		end
	end

	private
		def holiday_params
		params.require(:holiday).permit(:startdate, :enddate, :description) 
	end

  def make_sure_its_mine
      @user = Holiday.find(params[:id]).user
      unless current_user.id == @user.id or current_user.admin == true
        redirect_to holidays_path, alert: "It's not yours!"
      end
      true
    end

  def make_sure_its_admin
      unless current_user.admin == true
        redirect_to holidays_pathm alert: "You are not admin! You wanted to hack this app? I don't think so maaaan!"
      end
      true
  end

end