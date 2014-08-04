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

