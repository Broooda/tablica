require 'rails_helper'

RSpec.describe UsersController, type: :controller do


  before(:each) do
   # @user=User.create(name: "Jan", surname: "Kowalski", email: "test@mail.pl", password: "razdwatrzycztery")
    #sign_in @user

    @user=User.create(name: "Jan", surname: "Kowalski", email: "test@mail.pl", password: "razdwatrzycztery")
    sign_in @user
   end


   describe "GET #index" do
      it 'responds successfully with an HTTP 200 status code' do
       # puts current_user
        get :index
       #expect(response).to be_success
       # expect(response).to have_http_status(200)
      end


      # it 'renders the index template' do
      #   get :index
      #   expect(response).to render_template("index")
      # end

      # it 'loads all users into @users' do
      #   user1, user2 = User.create(name: "Anna", surname: "Owczarek"), User.create(name: "Robert", surname: "Kowalski")
      #   get :index
      #   expect(assigns(:users)).to match_array([user1, user2])
      # end
   end
end