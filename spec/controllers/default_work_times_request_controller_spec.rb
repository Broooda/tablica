require 'rails_helper'

RSpec.describe DefaultWorkTimesRequestController, :type => :controller do

  describe "DELETE #destroy" do
    before(:each) do
      @user=User.create(name: "Jan", surname: "Kowalski", email: "test6463@mail.pl", password: "razdwatrzycztery", accepted: true, admin: true)
      sign_in @user
    end

    DefaultWorkTimeRequest.create(user_id: 1.to_param, description: "description", status: "pending")

    # it 'should destroy object' do
    #   DefaultWorkTimeRequest.should_receive(:delete!)
    #   delete :destroy, :user_id => 1
    # end
  end 
end
