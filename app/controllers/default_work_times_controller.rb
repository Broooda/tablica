class DefaultWorkTimesController < ApplicationController
before_action :make_sure_its_mine, only: [:destroy, :show]
 
  def show 
    @d=current_user.default_work_time
    @dr=@d.user.default_work_time_request
  end

  def update_work_time
    if current_user.default_work_time_request && current_user.default_work_time_request.status=="pending"
      redirect_to default_work_time_path(current_user.default_work_time.id), alert: "Request already exists"
    else
       create_new_request
    end
  end

  def accept
    DefaultWorkTime.accepted(DefaultWorkTimeRequest.find(params[:id]))
    redirect_to inboxs_path, notice: "Default hours accepted"
  end

  def reject
    request = DefaultWorkTimeRequest.find(params[:id])
    request.status = "rejected"
    request.reason = params['description']
    request.save
    redirect_to inboxs_path, notice: "Default hours rejected"
  end

  def generate_hours_plans_admin
    if current_user.admin
      DefaultWorkTime.generate_hours_plans
      flash[:notice] = "Hours plans generated"
    end
    redirect_to root_path
  end

  def generate_few_weeks
    if current_user.admin
      DefaultWorkTime.generate_few_weeks
      flash[:notice] = "Hours plans generated"
    end
    redirect_to root_path
  end

  private

  def create_new_request
    DefaultWorkTimeRequest.where('user_id = :user_id', {user_id: current_user.id}).destroy_all
    new_default=DefaultWorkTimeRequest.new(week: [[params['monday_start'],params['monday_end']],[params['tuesday_start'], params['tuesday_end']],[params['wednesday_start'], params['wednesday_end']],[params['thursday_start'],params['thursday_end']],[params['friday_start'],params['friday_end']]],description: params['description'], user_id: current_user.id, status: 'pending')
    if new_default.valid?
      new_default.save
      redirect_to default_work_time_path(current_user.default_work_time.id), notice: "Request added"
    else
       @d=current_user.default_work_time
       @dr=new_default
      render 'show'
    end
  end

  def make_sure_its_mine
    @user = DefaultWorkTime.find(params[:id]).user
    return false if current_user.id == @user.id or current_user.admin == true
      redirect_to user_path, alert: "You can't edit that."
  end

end

