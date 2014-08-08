require 'rails_helper'

RSpec.describe HoursPlan, :type => :model do

  it 'should belong to user' do
    t = HoursPlan.reflect_on_association(:user)
    expect(t.macro).to equal :belongs_to
 	end

   it 'should return 9:00, when they are at the same time at work' do
  @user=User.create(name: "Jan", surname: "Kowalski", email: "test@mail.pl", password: "razdwatrzycztery", accepted: true)
  DefaultWorkTime.create(week: [['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id: User.last.id)
 
  @user2=User.create(name: "Jan", surname: "Kowalski", email: "test2@mail.pl", password: "razdwatrzycztery", accepted: true)
  DefaultWorkTime.create(week: [['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id: User.last.id)
  DefaultWorkTime.generate_few_weeks

  expect(HoursPlan.most_people_at_the_same_time(DateTime.commercial(Date.today.year, Date.today.cweek+1, 1,0,0,0,'+2'), DateTime.commercial(Date.today.year, Date.today.cweek+1, 2,0,0,0,'+2'))).to include({max_people: 2, people: [@user,@user2]})
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

  it 'start_date_must_be_before_end_date' do
  expect(HoursPlan.new(start_date: Time.new(2014, 4, 2), end_date: Time.new(2014, 3, 1), user_id: 2)).not_to be_valid
 end

  it "passes for equal time" do
    expect(Time.now).to be_the_same_time_as Time.now
  end
 
  it "doesn't pass for different time" do
    expect(Time.now).to_not be_the_same_time_as Time.new(2014, 4, 2)
  end
end
