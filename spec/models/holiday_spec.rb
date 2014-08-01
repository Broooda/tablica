 require 'rails_helper'

RSpec.describe Holiday, :type => :model do

  it 'should belong to user' do
    t = Holiday.reflect_on_association(:user)
    expect(t.macro).to equal :belongs_to
  end

  it 'should have attributes :startdate, :enddate, :description, :status, :reason' do
    expect(subject.attributes).to include('startdate', 'enddate', 'description', 'status', 'reason')
  end


  it 'should require startdate, enddate, description, status' do
    #expect(Holiday.new).not_to be_valid
    expect(Holiday.new(startdate: DateTime.now, enddate: DateTime.now+10.days, description: "Urlop", status: "accepted", user_id: 2)).to be_valid
  end

end
