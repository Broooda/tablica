require 'rails_helper'

RSpec.describe DefaultWorkTimesRequestController, :type => :controller do

  describe "DELETE #destroy" do
    DefaultWorkTimeRequest.create(user_id: @user.id, description: "description", status: "pending")

    it 'should destroy object' do
      # ..
    end
  end 
end
