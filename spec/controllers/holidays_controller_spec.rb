require 'rails_helper'

RSpec.describe HolidaysController, type: :controller do

  before(:each) do
    @user=User.create(name: "Jan", surname: "Kowalski", email: "test@mail.pl", password: "razdwatrzycztery", accepted: true)
    sign_in @user
   end
   describe "GET #index" do
      it 'responds successfully with an HTTP 200 status code' do
        get :index
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
   end
     it "renders the index template" do
     get :index
     expect(response).to render_template("index")
   end
   # New test
    describe "GET #new" do
      it "assigns a new Project to @holiday" do
      get :new
      assigns(:holiday).should be_a_new(Holiday)
    end
  end 
  describe "GET #new" do
      context 'when resource is not found' do
      it 'responds with 404'
  end
end
      # it 'should have display requests with "accepted" ' do
      #     h1=Holiday.create(startdate: DateTime.now, enddate: DateTime.now+10.days, description: "Urlop", status: "accepted", user_id: 2)
      #     h2=Holiday.create(startdate: DateTime.now, enddate: DateTime.now+10.days, description: "Urlop", status: "accepted", user_id: 1)
      #     get :accepted
      #     expect(assigns(:holiday)).to match_array([h1,h2])
   # end
# describe "PUT 'update/:id'" do
#   it "allows an holiday to be updated" do
#     prev_updated_at = @holiday.updated_at
#     @attr = { :startdate => "2014-07-07 23:03:00", :enddate => "2014-08-30 03:09:00", :description => "assda", :status =>"pending"}
#     put :update, :id => @holiday.id, :startdate => @attr ,:enddate =>@atrr
#     @holiday.reload
#     @holiday.updated_at.should != prev_updated_at 
#   end
# end
end



