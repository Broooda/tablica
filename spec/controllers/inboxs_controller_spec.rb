require 'rails_helper'


RSpec.describe InboxsController, type: :controller do

  before(:each) do
    @user=User.create(name: "Jan", surname: "Kowalski", email: "test@mail.pl", password: "razdwatrzycztery", accepted: true, admin: true)
    sign_in @user
    DefaultWorkTime.create(week: [['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id: User.last.id)
   end


   describe "GET #index" do
      it 'responds successfully with an HTTP 200 status code' do
        get :index
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

   #    it 'should have display requests with pending ' do
   #      d1=DefaultWorkTimeRequest.create(week: [['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id: 2, status: "pending", description: "tralallalaal")
   #      d2=DefaultWorkTimeRequest.create(week: [['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id: 1, status: "pending", description: "tralallalaal")
   #      h1=Holiday.create(startdate: DateTime.now, enddate: DateTime.now+10.days, description: "Urlop", status: "pending", user_id: 2)
   #      h2=Holiday.create(startdate: DateTime.now, enddate: DateTime.now+10.days, description: "Urlop", status: "pending", user_id: 1)
   #      get :index
   #      expect(assigns(:dr)).to match_array([d1,d2])
   #      expect(assigns(:holiday)).to match_array([h1,h2])

   #    end
   end

   describe "Get def manual_generate" do
      it 'responds successfully with an HTTP 200 status code' do
        get :manual_generate
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end


   describe "manual_generate_post" do
      it 'generate 2 weeks hours, redirect to root' do
        post :manual_generate_post, week: Time.now+2.week
        expect(HoursPlan.all.size).to be > 10
        expect(response).to redirect_to(root_url)
      end
    end

end

