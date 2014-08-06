class OverHoursController < ApplicationController
  
  def index
    @overs=OverHour.where(user_id: current_user.id)
    @over_hour=OverHour.new
  end

  def new
    @over_hour=OverHour.new
  end

  def create
    @over_hour = OverHour.new(over_hour_params)
    @over_hour.status='pending'
    @over_hour.user_id=current_user.id
    if @over_hour.save
      redirect_to over_hours_path, notice: "Over hours request added"
    else
      @overs=OverHour.where(user_id: current_user.id)
      render 'index'
    end
  end

  def destroy
    @over_hour=OverHour.find(params[:id])
    if @over_hour.destroy
      redirect_to over_hours_path, notice:"Request deleted"
    else
      redirect_to over_hours_path, alert: "Error"
    end
  end

  def accept
    @over=OverHour.find(params[:id])
    @over.status='accepted'
    @over.save
    redirect_to inboxs_path, notice: "Accepted"
  end

  def reject
    @over=OverHour.find(params[:id])
    @over.status='rejected'
    @over.save
    redirect_to inboxs_path, notice: "Rejected"
  end

  private

  def over_hour_params
    params.require(:over_hour).permit(:hours, :date, :description)
  end

end