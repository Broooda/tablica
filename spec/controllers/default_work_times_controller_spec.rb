require 'rails_helper'


RSpec.describe DefaultWorkTimesController, type: :controller do

  before(:each) do
    @user=User.create(name: "Jan", surname: "Kowalski", email: "test@mail.pl", password: "razdwatrzycztery", accepted: true)
    sign_in @user

    @default=DefaultWorkTime.create(week: [['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id: User.last.id)
  end

  describe "GET #show" do
    it "should respond successfully with status 200" do
       get :show, id: @default.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "should generate show template" do
      get :show, id: @default.id
      expect(response).to render_template('show')
    end
  end
  describe"update_work_time" do
    it "should redirect to default_work_time_path due to pending request" do
      DefaultWorkTimeRequest.create(week: [['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id: @user.id, status: "pending", description: "tralallalaal")
      post :update_work_time, monday_start: '9:00', monday_end: '16:00', tuesday_start: '9:00',tuesday_end: '16:00',wednesday_start: '9:00',wednesday_end: '16:00',thursday_start: '9:00',thursday_end: '16:00',friday_start:'9:00' ,friday_end: '16:00', description: "tralallalaal"
      expect(response).to redirect_to(default_work_time_path(@default.id))
    end
 
    it "should create request" do
     DefaultWorkTimeRequest.create(week: [['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id: @user.id, status: "accepted", description: "tralallalaal")
     get :update_work_time, monday_start: '9:00', monday_end: '16:00', tuesday_start: '9:00',tuesday_end: '16:00',wednesday_start: '9:00',wednesday_end: '16:00',thursday_start: '9:00',thursday_end: '16:00',friday_start:'9:00' ,friday_end: '16:00', description: "tralallalaal"
     expect(DefaultWorkTimeRequest.all.size).to match(1) 
     expect(response).to redirect_to(default_work_time_path(@default.id))
    end
  end

  describe"get accept" do
    it "should change status to accepted, and redirect" do
    DefaultWorkTimeRequest.create(week: [['10:00','18:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id: @user.id, status: "pending", description: "tralallalaal")
    post :accept, id: DefaultWorkTimeRequest.last.id
    expect(DefaultWorkTime.last.week[0][0]).to match('10:00')
    expect(HoursPlan.all.size).to be > 0
    expect(response).to redirect_to(inboxs_path)
    end
  end
  describe"get reject" do
    it "should change status to rejected, and redirect" do
    DefaultWorkTimeRequest.create(week: [['10:00','18:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id: @user.id, status: "pending", description: "tralallalaal")
    post :reject, id: DefaultWorkTimeRequest.last.id, reason: 'NIE!'
    expect(DefaultWorkTime.last.week[0][0]).to match('9:00')
    expect(DefaultWorkTimeRequest.last.status).to match('rejected')
    expect(response).to redirect_to(inboxs_path)
    end
  end

  describe" generate_hours_plans_admin" do
    it "should generate HoursPlans" do
      DefaultWorkTime.generate_hours_plans
      expect(HoursPlan.all.size).to be > 0
  end
end

  describe" generate_hours_plans_admin" do
    it "should generate few weeks" do
      DefaultWorkTime.generate_few_weeks
    expect(HoursPlan.all.size).to be > 0
  end
end
end
    

