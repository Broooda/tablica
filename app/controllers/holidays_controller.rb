class HolidaysController < ApplicationController
before_action :make_sure_its_mine, only: [:destroy, :edit, :update]
before_action :make_sure_its_admin, only: [:accept, :reject]
	
  def index
    @holiday= Holiday.where('user_id=:user_id',{user_id: current_user.id})
  end

	def destroy
    if Holiday.find(params[:id]).destroy
      redirect_to holidays_path alert: "Removed Holiday "
    else
      redirect_to holidays_path alert: "Not Removed Holiday "
    end
  end

  def accept
    @holiday = Holiday.find(params[:id])
    @holiday.status = "accepted"
    @holiday.save
    first_week=@holiday.startdate.to_date.cweek-Time.now.to_date.cweek
    last_week=@holiday.enddate.to_date.cweek-Time.now.to_date.cweek
    (first_week..last_week).each do |counter|
      DefaultWorkTime.generate_hours_plans(counter, @holiday.user_id)
    end
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
    @holiday=Holiday.new
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

  def make_sure_its_mine
    @user = Holiday.find(params[:id]).user
    return true if current_user.id == @user.id or current_user.admin == true
      redirect_to holidays_path, alert: "It's not yours!"
  end

  def make_sure_its_admin
    return true if current_user.admin == true
      redirect_to holidays_pathm alert: "You are not admin! You wanted to hack this app? I don't think so maaaan!"
  end

end