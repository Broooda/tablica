require 'rails_helper'

RSpec.describe HolidaysController, type: :controller do


  before(:each) do
    @user=User.create(name: "Jan", surname: "Kowalski", email: "test@mail.pl", password: "razdwatrzycztery", accepted: true)
    sign_in @user
   end

 #  	integrete_views
  	
  	it "should redirect holidays index with a notice Created Holiday "
  	post 'create'
  	flash[:notice].should_not be_nil
 	response.shoud redirect_to(holidays_path)
	end
	# it "should redirect holidays index with a notice Created Holiday "
 #  	get 'new'
 #  	flash[:notice].should_not be_nil
 # 	response.shoud redirect_to(holidays_path)
	# end
end