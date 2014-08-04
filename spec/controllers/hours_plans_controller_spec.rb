require 'rails_helper'


RSpec.describe HoursPlansController, type: :controller do

  before(:each) do
    @user=User.create(name: "Jan", surname: "Kowalski", email: "test@mail.pl", password: "razdwatrzycztery", accepted: true)
    sign_in @user
    @default=DefaultWorkTime.create(week: [['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id: User.last.id)
    DefaultWorkTime.generate_hours_plans(1,@user.id)
   end

  describe "GET #edit" do
    it "should respond successfully with status 200" do
       get :edit, id: HoursPlan.last
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "should generate show template" do
      get :edit, id: HoursPlan.last
      expect(response).to render_template('edit')
    end

end

describe "Patch #update" do
    it 'should redirect to week_time_url after update' do
      hours_plan=HoursPlan.create(start_date: "10:00".to_time ,end_date:"15:00".to_time, user_id: @user.id)
      patch :update, id: hours_plan.id, post: {over_hours: 2, user_id: @user.id}
      expect(response).to redirect_to(week_time_url)
    end
  end
end