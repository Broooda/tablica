require 'rails_helper'

RSpec.describe RaportsController, type: :controller do

  before(:each) do
    @user=User.create(name: "Jan", surname: "Kowalski", email: "test@mail.pl", password: "razdwatrzycztery", accepted: true)
    sign_in @user

    @default=DefaultWorkTime.create(week: [['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id: User.last.id)
    @holiday=Holiday.create(id: 1, startdate: DateTime.now-2, enddate: DateTime.now-1, description: "Because", status: "accepted", reason: "Because", user_id: User.last.id)
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
    get :index
    expect(response).to be_success
    expect(response).to have_http_status(200)
    end
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
    get :new
    expect(response).to be_success
    expect(response).to have_http_status(200)
    end
  end

  describe "Type pdf" do
    it "creates a resource" do  
      expect(response).to respond_with_content_type(:pdf)
    end
  end


  # describe "GET #index" do
  #   it 'responds successfully with an HTTP 200 status code' do
  #     get :index
  #     expect(response).to be_success
  #     expect(response).to have_http_status(200)
  #   end


  #   it 'renders the index template' do
  #     get :index
  #     expect(response).to render_template("index")
  #   end

  # it 'loads all raports into @raports' do
  #   raport1, raport2 = Raport.create(name: "Anna", surname: "Owczarek", email: "test222@mail.pl", password: "razdwatrzycztery", accepted: true), User.create(name: "Robert", surname: "Kowalski", email: "test424@mail.pl", password: "razdwatrzycztery", accepted: true)
  #   get :index
  #   expect(assigns(:users)).to match_array([user1, user2,@user])
  # end
 # end
end
