class InboxsController < ApplicationController
  
  def index
    @holiday=Holiday.where("status='pending'")
    @dr=DefaultWorkTimeRequest.where("status='pending'")
  end

end