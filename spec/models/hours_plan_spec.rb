require 'rails_helper'

RSpec.describe HoursPlan, :type => :model do

  it 'should belong to user' do
    t = HoursPlan.reflect_on_association(:user)
    expect(t.macro).to equal :belongs_to
 	end
 end

RSpec::Matchers.define :be_the_same_time_as do |expected|
  match do |actual|
    expect(expected.strftime("%Y,%m,%d")).to eq(actual.strftime("%Y,%m,%d"))
  end

end
 
describe "time comparison" do
  it "passes for equal dates" do
    expect(Time.new(2014, 4, 2)).to be_the_same_time_as Time.new(2014, 4, 2)
  end
 
  it "passes for equal time" do
    expect(Time.now).to be_the_same_time_as Time.now
  end
 
  it "doesn't pass for different time" do
    expect(Time.now).to_not be_the_same_time_as Time.new(2014, 4, 2)
  end
end
