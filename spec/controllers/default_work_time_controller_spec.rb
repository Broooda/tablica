require 'rails_helper'


RSpec.describe DefaultWorkTimesController, type: :controller do

  before(:each) do
    @default=DefaultWorkTime.create(week: [['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id: 1)
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
end