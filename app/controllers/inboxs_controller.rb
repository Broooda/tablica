class InboxsController < ApplicationController
  before_action :authenticate_user!
  before_action :make_sure_im_admin

  def index
      @holiday=Holiday.where("status='pending'")
      @dr=DefaultWorkTimeRequest.where("status='pending'")
  end

  def manual_generate
  end

  def manual_generate_post

      current_week=Time.now.to_date.cweek
      last_week=params['week'].to_date.cweek     
      difference=last_week-current_week
      if difference > 0
        (0..difference).each do |counter|
          DefaultWorkTime.generate_hours_plans(counter)    
        end
         redirect_to root_url, alert: "Hours generated"
      else
        redirect_to manual_generate_path, alert: "Wrong date!"
      end
  end

  def make_sure_im_admin
     unless current_user.admin
       redirect_to root_url, alert: "Only for Admins"
     end
  end


end