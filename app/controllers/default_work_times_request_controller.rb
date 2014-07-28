class DefaultWorkTimesRequestController < ApplicationController
before_action :make_sure_its_mine, only: [:destroy]

def destroy
    @default_work_time_request=DefaultWorkTimeRequest.find(params[:id])

    default_work_time_id=User.find(@default_work_time_request.user_id).default_work_time.id

    if @default_work_time_request.destroy
      redirect_to default_work_time_path(default_work_time_id), notice:"Request deleted"
    else
      redirect_to default_work_time_path(default_work_time_id), alert: "Error"
    end
  end

  def make_sure_its_mine
      @user = DefaultWorkTimeRequest.find(params[:id]).user
      unless current_user.id == @user.id or current_user.admin == true
        redirect_to user_path, alert: "It's not yours!"
      end
      true
    end
end