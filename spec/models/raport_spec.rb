require 'rails_helper'

# :user_id, :date_end, :holiday_hours, :work_hours

RSpec.describe Raport, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it 'should require date_begin, date_end' do
  expect(Raport.new(id:"1",user_id:'3',date_begin: DateTime.now, date_end: DateTime.now+10.days,created_at: DateTime.now, updated_at: DateTime.now+2.days, holiday_hours: "3", work_hours: "28")).to be_valid
  end
  it 'should require date_end,date_begin' do	
	expect(Raport.new(date_begin: :nill)).not_to be_valid
	# expect(Raport.new(date_begin: DateTime.now)).to be_valid
	expect(Raport.new(date_end: :nill)).not_to be_valid
	# expect(Raport.new(date_end: DateTime.now + 7.days)).not_to be_valid
	expect(Raport.new(user_id: :nill)).not_to be_valid
	expect(Raport.new(holiday_hours: :nill)).not_to be_valid
end
end