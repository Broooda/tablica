require 'rails_helper'

RSpec.describe DefaultWorkTimeRequest, type: :model do

   before(:each) do
    @default=DefaultWorkTimeRequest.new(week: [['9:00:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id: 1, description: "desk", status: "pending")
   end


  it 'should have validate "it must be array with length 5 of arrays length 2" ' do
   expect(DefaultWorkTimeRequest.new).not_to be_valid
   expect(DefaultWorkTimeRequest.new(user_id: 1)).not_to be_valid
   expect(DefaultWorkTimeRequest.new(week: [['9:00','16:00'],['9:00','16:00']],user_id: 1)).not_to be_valid
   expect(@default).to be_valid
  end

  it 'should have validate "no empty fields & start hour < end hour" ' do
    default_changed=@default  
    default_changed.week[0][0]="20:00"
 
    expect(default_changed).not_to be_valid

    default_changed.week[0][0]=""

    expect(default_changed).not_to be_valid  
  end
 
  it 'should belongs to user' do
    t= DefaultWorkTimeRequest.reflect_on_association(:user)
    expect(t.macro).to equal :belongs_to
  end

end