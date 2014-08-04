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
  
end



