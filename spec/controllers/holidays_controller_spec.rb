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
    context 'when resource is found' do
    it 'responds with 200'
    it 'shows the resource'
  end
    context 'when resource is not found' do
    it 'responds with 404'
  end
  # describe "delete holiday" do
  #   expect { delete :destroy, :id => @user }.to_not change(Holiday, :count)
  # end
    #  it "should set the flash" do
    #     # @holiday = Holiday.create(startdate: "2014-07-07 23:03:00", enddate: "2014-08-30 03:09:00", description: "assda", status: "pending", reason: nil, created_at: "2014-08-01 09:32:10", updated_at: "2014-08-01 09:32:10", user_id: "2")
    #     delete :destroy, :id => 1
    #     flash[:notice].should =~ /Removed Holiday/i
    # end
end



