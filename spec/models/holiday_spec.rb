require 'rails_helper'

RSpec.describe Holiday, :type => :model do
  it 'should belong to user' do
    t = Holiday.reflect_on_association(:user)
    expect(t.macro).to equal :belongs_to
  end

  it 'should have attributes :startdate, :enddate, :description, :status, :reason' do
    expect(subject.attributes).to include('startdate', 'enddate', 'description', 'status', 'reason')
  end

  it 'must have startdate' do
    subject.should have(1).error_on(:startdate)
  end
end
