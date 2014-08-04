require 'rails_helper'

RSpec.describe RaportsController, :type => :controller do

before(:each) do
@user=User.create(email: 'admin@test.pl', password: 'admin123')
sign_in @user
end



end
