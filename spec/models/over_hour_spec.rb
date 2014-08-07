require 'rails_helper'

RSpec.describe OverHour, :type => :model do
	it 'should belong to user' do
	 t = OverHour.reflect_on_association(:user)
	 expect(t.macro).to equal :belongs_to
	end
		it 'should require date,status,description,hours' do	
		 expect(OverHour.new(date: :nill)).not_to be_valid
		 expect(OverHour.new(status: "")).not_to be_valid
		 expect(OverHour.new(description: "")).not_to be_valid
		 expect(OverHour.new(hours: "")).not_to be_valid
	end

	it 'date, :status, :user_id, :description, :hours' do
	 expect(subject.attributes).to include('date', 'status', 'description' , 'hours')
	end
		describe "time comparison" do
  	it "passes for equal dates" do
    expect(Time.new(2014, 4, 2)).to be_the_same_time_as Time.new(2014, 4, 2)
  end
 end
end