require 'rails_helper'

RSpec.describe DefaultWorkTimesRequestController, :type => :controller do

  describe "DELETE #destroy" do
    DefaultWorkTimeRequest.create(user_id: 1, description: "description", status: "pending")

    it 'should destroy object' do
      delete :destroy, :id => 1
    end
  end 
end
