require 'rails_helper'

RSpec.describe DefaultWorkTimesRequestController, :type => :controller do

  describe "DELETE #destroy" do
    DefaultWorkTimeRequest.create(user_id: 1.to_param, description: "description", status: "pending")

    it 'should destroy object' do
      DefaultWorkTimesRequest.any_instance.should_receive(:delete!)
      delete :destroy, :id => 1.to_param, format: 'js'
    end
  end 
end
