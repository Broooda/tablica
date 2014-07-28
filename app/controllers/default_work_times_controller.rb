class DefaultWorkTimesController < ApplicationController
before_action :make_sure_its_mine, only: [:destroy, :show]
 
  def show 
    @d=DefaultWorkTime.find(params[:id])
    @dr=DefaultWorkTimeRequest.all
  end

  def update_work_time
    #If user has DefaultWorkTimeRequest object
    if User.find(current_user.id).default_work_time_request
      #If this object's status is 'pending'
      if User.find(current_user.id).default_work_time_request.status=="pending"
        #Error, redirect 
        redirect_to default_work_time_path(User.find(current_user.id).default_work_time.id), alert: "Request already exists"
      else
        create_new_request
      end
    #If user has no DefaultWorkTimeRequest object
    else
      create_new_request
    end
  end

  def accept
    @request = DefaultWorkTimeRequest.find(params[:id])
    #DefaultWorkTimeRequest.find(params[:id]).destroy
    @request.status = "accepted"
    @request.user.default_work_time.week=@request.week
    @request.save
    @request.user.default_work_time.save

    last=HoursPlan.order( 'start_date ASC' )
    last=last.last
    current_week=Time.now.to_date.cweek
    last_week=last.start_date.to_date.cweek
    difference=last_week-current_week

    (0..difference).each do |counter|
      DefaultWorkTime.generate_hours_plans(counter)
    
    end

    redirect_to inboxs_path, notice: "Default hours accepted"
  end

  def reject
    @request = DefaultWorkTimeRequest.find(params[:id])
    #DefaultWorkTimeRequest.find(params[:id]).destroy
    @request.status = "rejected"
    @request.reason = params['description']
    @request.save
    redirect_to inboxs_path, notice: "Default hours rejected"
  end

  def generate_hours_plans_admin
    if(current_user.admin)
      DefaultWorkTime.generate_hours_plans
      flash[:notice] = "Hours plans generated"
    end
    redirect_to root_path
  end

  private
  def create_new_request
    #usun aktualne requesty uzytkownika
    DefaultWorkTimeRequest.where('user_id = :user_id', {user_id: current_user.id}).destroy_all

    #Create object with params
    new_default=DefaultWorkTimeRequest.new(week: [[params['monday_start'],params['monday_end']],[params['tuesday_start'], params['tuesday_end']],[params['wednesday_start'], params['wednesday_end']],[params['thursday_start'],params['thursday_end']],[params['friday_start'],params['friday_end']]],description: params['description'], user_id: current_user.id, status: 'pending')
    #If valid save object and redirect
    if new_default.valid?
      new_default.save
      redirect_to default_work_time_path(User.find(current_user.id).default_work_time.id), notice: "Request added"
    #If not valid redirect with notice
    else
      redirect_to default_work_time_path(User.find(current_user.id).default_work_time.id), alert: new_default.errors.full_messages.first
    end
  end

  def make_sure_its_mine
      @user = DefaultWorkTime.find(params[:id]).user
      unless current_user.id == @user.id or current_user.admin == true
        redirect_to user_path, alert: "You can't edit that."
      end
      true
    end

end

