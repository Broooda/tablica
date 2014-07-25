require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before(:each) do
   # @user=User.create(name: "Jan", surname: "Kowalski", email: "test@mail.pl", password: "razdwatrzycztery")
    #sign_in @user

    @default=User.create()
   end
end