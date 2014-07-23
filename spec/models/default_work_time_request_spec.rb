require 'rails_helper'

RSpec.describe DefaultWorkTimeRequest, type: :model do
  it 'should have validate "it must be array with length 5 of arrays length 2" ' do
   expect(DefaultWorkTimeRequest.new).not_to be_valid
    expect(DefaultWorkTimeRequest.new(week: [['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id: 1, description: "blablablabla", status: "pending")).to be_valid
  end
  it 'should belongs to user' do
    t= DefaultWorkTime.reflect_on_association(:user)
    expect(t.macro).to equal :belongs_to
  end

end