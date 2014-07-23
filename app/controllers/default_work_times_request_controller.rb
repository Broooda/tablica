class DefaultWorkTimesRequestController < ApplicationController
def new
    @dr=DefaultWorkTimeRequest.new
  end

  def create
    @dr=DefaultWorkTimeRequest.new(defaultworktimerequest_params)
     if @dr.save
      redirect_to root_url, notice:"Uzytkownik stworzony"
    else
      render 'new'
    end 
  end

  private
  def defaultworktime_params
    params.require(:default_work_time).permit(:week, :user_id, :description, :status)
  end


end