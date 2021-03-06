require 'rails_helper'

RSpec.describe UsersController, type: :controller do


  before(:each) do
    @user=User.create(name: "Jan", surname: "Kowalski", email: "test6463@mail.pl", password: "razdwatrzycztery", accepted: true, admin: true)
    sign_in @user
  end

  describe "GET #index" do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template("index")
    end

    it 'loads all users into @users' do
      user1, user2 = User.create(name: "Anna", surname: "Owczarek", email: "test222@mail.pl", password: "razdwatrzycztery", accepted: true), User.create(name: "Robert", surname: "Kowalski", email: "test424@mail.pl", password: "razdwatrzycztery", accepted: true)
      get :index
      expect(assigns(:users)).to match_array([user1, user2,@user])
    end
  end

  describe " #update" do
    it 'should redirect after create to @user,' do
      post :update, user: {name: 'content posta', surname: "Tratat", email: "test222@mail.pl", tags: "tt"}, id: @user.id
      expect(response).to redirect_to(@user)
    end
  end

  describe "GET #edit" do
    it 'it should generate edit' do
      get :edit, id: @user.id
      expect(assigns(:user)).to match(@user)
    end
  end
end