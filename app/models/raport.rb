class Raport < ActiveRecord::Base

	validates :user_id, :date_begin, :holiday_hours, :work_hours, presence: true
  validates :date_end, presence: true
	validate :Comparing_dates

	private
		def Comparing_dates
      unless self.date_begin.blank? == true or self.date_end.blank? == true
            errors.add(:date_begin, "must be before end date") unless 
    self.date_begin < self.date_end
  end
    end

    #Raport.generate_raport(start_date, end_date, user_id)
    def self.generate_raport(start_date=Time.now-4.week, end_date=Time.now, user_id=1, current_user)
      if end_date.to_time
        work_days = HoursPlan.where(
          'user_id = ? and start_date > ? and start_date < ?',
          user_id,start_date.to_time,(end_date.to_time+1.day)
        )
        holiday_days = HolidaysPlan.where(
          'user_id = ? and holiday_date > ? and holiday_date < ?',
          user_id,start_date.to_time,end_date.to_time+1.day
        )

        work_minutes=0
        holiday_minutes=0

        work_days.each do |work_day|
          work_minutes+=TimeDifference.between(work_day.end_date, work_day.start_date).in_minutes
        end

        holiday_days.each do |holiday_day|
          holiday_minutes+=holiday_day.hours
        end

        work_hours=(work_minutes/60).to_i
        holiday_hours=(holiday_minutes/60).to_i

        work_minutes=(work_minutes-work_hours*60).to_i
        holiday_minutes=(holiday_minutes-holiday_hours*60).to_i

        work_hours=work_hours.to_s+" hours and "+work_minutes.to_s+" minutes"
        holiday_hours=holiday_hours.to_s+" hours and "+holiday_minutes.to_s+" minutes"
        
        Raport.new(user_id: current_user.id, holiday_hours: holiday_hours, work_hours: work_hours, date_begin: start_date, date_end: end_date, generator_id: user_id)
      else
        Raport.new()
      end
    end

    def generate_admin_raport(start_date=Time.now-4.week, end_date=Time.now, current_user)

      if end_date.to_time
        counter=0
        work_days = HoursPlan.where(
          'start_date > ? and start_date < ?',
          start_date.to_time,(end_date.to_time+1.day)
        )
        holiday_days = HolidaysPlan.where(
          'holiday_date > ? and holiday_date < ?',
          start_date.to_time,end_date.to_time+1.day
        )

        User.all.each do |user|
          his_work=work_days.where('user_id = user.id')
          his_holiday=holiday_days.where('user_id = user.id')

        work_minutes=0
        holiday_minutes=0

        his_work.each do |work_day|
          work_minutes+=TimeDifference.between(work_day.end_date, work_day.start_date).in_minutes
        end

        his_holiday.each do |holiday_day|
          holiday_minutes+=holiday_day.hours
        end

        work_hours=(work_minutes/60).to_i
        holiday_hours=(holiday_minutes/60).to_i

        work_minutes=(work_minutes-work_hours*60).to_i
        holiday_minutes=(holiday_minutes-holiday_hours*60).to_i

        work_hours=work_hours.to_s+" hours and "+work_minutes.to_s+" minutes"
        holiday_hours=holiday_hours.to_s+" hours and "+holiday_minutes.to_s+" minutes"
        
        raports[counter]=Raport.new(user_id: current_user.id, holiday_hours: holiday_hours, work_hours: work_hours, date_begin: start_date, date_end: end_date, generator_id: user_id)
        end

      else
        Raport.new() 
      end
    end
end
