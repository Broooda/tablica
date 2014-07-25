class DefaultWorkTimesController < ApplicationController

  def show 
    @d=DefaultWorkTime.find(params[:id])
    @dr=DefaultWorkTimeRequest.all
   
  end
  def update_work_time
    #If user has DefaultWorkTimeRequest object
    if User.find(params['user_id']).default_work_time_request
      #If this object's status is 'pending'
      if User.find(params['user_id']).default_work_time_request.status=="pending"
        #Error, redirect 
        redirect_to default_work_time_path(User.find(params['user_id']).default_work_time.id), notice: "Request already exists"
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


  private
  def create_new_request
      #Create object with params
        new_default=DefaultWorkTimeRequest.new(week: [[params['monday_start'],params['monday_end']],[params['tuesday_start'], params['tuesday_end']],[params['wednesday_start'], params['wednesday_end']],[params['thursday_start'],params['thursday_end']],[params['friday_start'],params['friday_end']]],description: params['description'], user_id: params['user_id'], status: 'pending')
        #If valid save object and redirect
        if new_default.valid?
          new_default.save
          redirect_to default_work_time_path(User.find(params['user_id']).default_work_time.id), notice: "Request added"
        #If not valid redirect with notice
        else
          redirect_to default_work_time_path(User.find(params['user_id']).default_work_time.id), alert: new_default.errors.full_messages.first
        end
  end

end

