require 'rails_helper'

RSpec.describe HolidaysController, type: :controller do

  before(:each) do
    @user=User.create(name: "Jan", surname: "Kowalski", email: "test@mail.pl", password: "razdwatrzycztery", accepted: true)
    @holiday=Holiday.create(startdate: "2014-07-07 23:03:00", enddate: "2014-08-30 03:09:00", description: "assda", status: "pending", reason: nil, created_at: "2014-08-01 09:32:10", updated_at: "2014-08-01 09:32:10", user_id: @user.id)
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
    describe "GET #new" do
      it "assigns a new Project to @holiday" do
      get :new
      assigns(:holiday).should be_a_new(Holiday)
    end
  end 

  describe "create" do
      it "should destroy holiday" do
      post :create, startdate: "2014-07-07", starttime: "10:00", enddate: "2014-08-30", endtime:"12:00", description: "assda"
      expect(Holiday.all.size).to match(2)
      post :create, startdate: "2014-07-07", starttime: "10:00", enddate: "2014-02-30", endtime:"12:00", description: "assda"
      expect(response).to render_template("new")
    end
  end 
  describe "update" do
    it "shoud update holiday" do
    post :update, id: @holiday.id, startdate: "2014-07-07", starttime: "10:00", enddate: "2014-08-30", endtime:"12:00", description: "nienieneie"
    expect(Holiday.last.description).to match("nienieneie")
  end
  end
end



