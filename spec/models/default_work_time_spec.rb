require 'rails_helper'

RSpec.describe DefaultWorkTime, type: :model do
  it 'should have validate "it must be array with length 5 of arrays length 2" ' do
   expect(DefaultWorkTime.new).not_to be_valid
    expect(DefaultWorkTime.new(week: [['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']]
, user_id: 1)).to be_valid
  end

  it 'should belongs to user' do
    t= DefaultWorkTime.reflect_on_association(:user)
    expect(t.macro).to equal :belongs_to
  end


end