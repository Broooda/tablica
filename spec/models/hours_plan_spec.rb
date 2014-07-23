require 'rails_helper'

RSpec.describe HoursPlan, :type => :model do
  		it 'should belong to user' do
		t=User.reflect_on_association(:user_id)
		expect(t.macro).to equal :belongs_to
	end
 	it 'should validate StartDate ,EndDate presence' do
    # expect(HoursPlan.new).not_to be_valid
    expect(HoursPlan.new(start_date:DateTime.now,end_date:DateTime.now)).to be_valid
  end
end
