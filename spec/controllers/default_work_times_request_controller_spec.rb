require 'rails_helper'

RSpec.describe DefaultWorkTimesRequestController, :type => :controller do

  describe "DELETE #destroy" do
    DefaultWorkTimeRequest.create(user_id: 1.to_param, description: "description", status: "pending")

    it 'should destroy object' do
      DefaultWorkTimeRequest.should_receive(:delete!)
      delete :destroy, :user_id => "1"
    end
  end 
end
