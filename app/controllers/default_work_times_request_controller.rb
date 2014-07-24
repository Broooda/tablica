class DefaultWorkTimesRequestController < ApplicationController
def destroy
    @default_work_time_request=DefaultWorkTimeRequest.find(params[:id])

    default_work_time_id=User.find(@default_work_time_request.user_id).default_work_time.id

    if @default_work_time_request.destroy
      redirect_to default_work_time_path(default_work_time_id), notice:"Request deleted"
    else
      redirect_to default_work_time_path(default_work_time_id), notice: "Error"
    end
  end
end