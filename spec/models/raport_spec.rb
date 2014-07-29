require 'rails_helper'

RSpec.describe Raport, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it 'should require startdate, enddate, description, status' do
  expect(Raport.new(date_begin: DateTime.now, date_end: DateTime.now+10.days,user_id: "1",hours_worked:"300s")).to be_valid
  end
end