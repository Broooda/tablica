require 'rails_helper'

RSpec.describe Raport, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it 'should require date_begin, date_end' do
    expect(Raport.new(id:"1",user_id:'3',date_begin: DateTime.now, date_end: DateTime.now+10.days,created_at: DateTime.now, updated_at: DateTime.now+2.days, holiday_hours: "3", work_hours: "28")).to be_valid
  end
  it 'should require date_end,date_begin' do	
	 expect(Raport.new(date_begin: :nill)).not_to be_valid
	 expect(Raport.new(date_end: "")).not_to be_valid
	 expect(Raport.new(user_id: "")).not_to be_valid
	 expect(Raport.new(holiday_hours: "")).not_to be_valid
	end

  it'[using DefaultWorkTime.generate_hours_plans] self.generate_raport should works....' do
    user=User.create(name: "Jan", surname: "Kowalski", email: "test@mail.pl", password: "razdwatrzycztery", accepted: true)
    DefaultWorkTime.create(week: [['09:00','16:00'],['09:00','16:00'],['09:00','16:00'],['09:00','16:00'],['09:00','16:00']], user_id: user.id)
    DefaultWorkTime.generate_hours_plans(2,user.id,user.id)
    Raport.generate_raport(Time.now, Time.now+2.week, user.id, user).save
    expect(Raport.all.size).to match(1)
  end

  it'[using DefaultWorkTime.generate_hours_plans] self.generate_ADMIN_raport should works....' do
    user=User.create(name: "Jan", surname: "Kowalski", email: "test@mail.pl", password: "razdwatrzycztery", accepted: true)
    DefaultWorkTime.create(week: [['09:00','16:00'],['09:00','16:00'],['09:00','16:00'],['09:00','16:00'],['09:00','16:00']], user_id: user.id)
    DefaultWorkTime.generate_hours_plans(2,user.id,user.id)

     user2=User.create(name: "Jan", surname: "Kowalski", email: "tes2t@mail.pl", password: "razdwatrzycztery", accepted: true)
    DefaultWorkTime.create(week: [['09:00','16:00'],['09:00','16:00'],['09:00','16:00'],['09:00','16:00'],['09:00','16:00']], user_id: user2.id)
    DefaultWorkTime.generate_hours_plans(2,user2.id,user2.id)

    Raport.generate_admin_raport(Time.now, Time.now+2.week,user).each do |r|
      r.save
    end
    expect(Raport.all.size).to match(2)
  end



end