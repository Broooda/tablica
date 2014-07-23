class DefaultWorkTimesController < ApplicationController
  def new
    @d=DefaultWorkTime.new
  end

  def create
    @d=DefaultWorkTime.new(defaultworktime_params)
     if @d.save
      redirect_to root_url, notice:"Uzytkownik stworzony"
    else
      render 'new'
    end 
  end

  def show 
    @d=DefaultWorkTime.find(params[:id])
   
  end

  def edit
    @default_work_time=DefaultWorkTime.find(params[:id])
  end

  def update
     @default_work_time=DefaultWorkTime.find(params[:id])
    if @default_work_time.update(defaultworktime_params)
      redirect_to root_url
    else
      render 'edit'
    end 
  end

  def update_work_time
    if User.find(params['user_id']).default_work_time_request.first.status="pending"
      redirect_to default_work_time_path(User.find(params['user_id']).default_work_time.id), notice: "Request already exists"
    else
    DefaultWorkTimeRequest.create(week: [[params['monday_start'],params['monday_end']],[params['tuesday_start'], params['tuesday_end']],[params['wednesday_start'], params['wednesday_end']],[params['thursday_start'],params['thursday_end']],[params['friday_start'],params['friday_end']]],description: params['description'], user_id: params['user_id'], status: 'pending')
    redirect_to root_url
  end
  end

  private
  def defaultworktime_params
    params.require(:default_work_time).permit(:week, :user_id)
  end

end

