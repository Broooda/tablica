require 'rails_helper'

RSpec.describe DefaultWorkTime, type: :model do
  
  it 'should have validate "it must be array with length 5 of arrays length 2" ' do
   expect(DefaultWorkTime.new).not_to be_valid
    expect(DefaultWorkTime.new(week: [['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id: 1)).to be_valid
  end
  it 'should belongs to user' do
    t= DefaultWorkTime.reflect_on_association(:user)
    expect(t.macro).to equal :belongs_to
  end

  it 'should generate 5 hours plans' do
    user=User.create(name: "Jan", surname: "Kowalski", email: "test@mail.pl", password: "razdwatrzycztery", accepted: true)
    DefaultWorkTime.create(week: [['09:00','16:00'],['09:00','16:00'],['09:00','16:00'],['09:00','16:00'],['09:00','16:00']], user_id: user.id)
    DefaultWorkTime.generate_hours_plans(1,user.id)
    expect(HoursPlan.all.size).to match(5)
  end

  it 'should generate 11 weeks hours plans (50)' do
   user=User.create(name: "Jan", surname: "Kowalski", email: "test@mail.pl", password: "razdwatrzycztery", accepted: true)
    DefaultWorkTime.create(week: [['09:00','16:00'],['09:00','16:00'],['09:00','16:00'],['09:00','16:00'],['09:00','16:00']], user_id: user.id)
    DefaultWorkTime.generate_few_weeks
    expect(HoursPlan.all.size).to match(54)
    end

    it 'shoud accept request' do
      
      user=User.create(name: "Jan", surname: "Kowalski", email: "test@mail.pl", password: "razdwatrzycztery", accepted: true)
      DefaultWorkTime.create(week: [['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id:  user.id)

      DefaultWorkTime.accepted(DefaultWorkTimeRequest.create(week: [['10:00','18:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id: user.id, status: "pending", description: "tralallalaal"))

      expect(DefaultWorkTimeRequest.last.status).to match("accepted")
      expect(user.default_work_time.week[0][0]).to match('10:00')
      expect(HoursPlan.all.size).to be > 0


    end



end