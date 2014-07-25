class InboxsController < ApplicationController
  
  def index
    @holiday=Holiday.all
    @dr=DefaultWorkTimeRequest.all
  end

end