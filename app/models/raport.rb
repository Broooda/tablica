class Raport < ActiveRecord::Base
  # validations
	validates :user_id, :date_begin, :holiday_hours, :work_hours, presence: true
  validates :date_end, presence: true
	validate :comparing_dates

	private
		def comparing_dates
      unless self.date_begin.blank? == true or self.date_end.blank? == true
        errors.add(:date_begin, "must be before end date") unless self.date_begin < self.date_end
      end
    end

    # Raport.generate_raport(start_date, end_date, user_id)
    def self.generate_raport(start_date=Time.now-4.week, end_date=Time.now, user_id=1, current_user)
      hours=[]
      if end_date.to_time
        work_days = HoursPlan.where(
          'user_id = ? and start_date > ? and start_date < ?',
          user_id,start_date.to_time,(end_date.to_time+1.day)
        )
        holiday_days = HolidaysPlan.where(
          'user_id = ? and holiday_date > ? and holiday_date < ?',
          user_id,start_date.to_time,end_date.to_time+1.day
        )
        over_hours = OverHour.where(
          'user_id = ? and date > ? and date < ? and status = ?',
          user_id,start_date.to_time,end_date.to_time+1.day,'accepted'
          )      

        hours=Raport.hours_counter(work_days,holiday_days,over_hours)

        Raport.new(user_id: current_user.id, holiday_hours: hours[1], work_hours: hours[0], over_hours: hours[2], date_begin: start_date, date_end: end_date, generator_id: user_id)

      else
        Raport.new()
      end
    end

    def self.generate_admin_raport(start_date=Time.now-4.week, end_date=Time.now, current_user)
      raports=[]
      hours=[]
     if end_date.to_time
        counter=0
        User.where(accepted: true).each do |user|
          work_days = HoursPlan.where(
          'user_id = ? and start_date > ? and start_date < ?',
          user.id,start_date.to_time,end_date.to_time+1.day,
        )
        holiday_days = HolidaysPlan.where(
          'user_id = ? and holiday_date > ? and holiday_date < ?',
          user.id,start_date.to_time,end_date.to_time+1.day
        )
        over_hours = OverHour.where(
          'user_id = ? and date > ? and date < ? and status = ?',
          user.id,start_date.to_time,end_date.to_time+1.day,'accepted'
          )

        hours=Raport.hours_counter(work_days,holiday_days, over_hours)
        raports[counter]=Raport.new(user_id: current_user.id, holiday_hours: hours[1], over_hours: hours[2], work_hours: hours[0], date_begin: start_date, date_end: end_date, generator_id: user.id)      
        counter+=1
        end
      else
        raports[0]=Raport.new() 
      end
     raports
    end

    def self.hours_counter(work_days, holiday_days, over_hours)
      work_minutes=0
      holiday_minutes=0
      over_minutes=0

      work_days.each do |work_day|
        work_minutes+=TimeDifference.between(work_day.end_date, work_day.start_date).in_minutes
      end

      holiday_days.each do |holiday_day|
        holiday_minutes+=holiday_day.hours
      end

      over_hours.each do |over_h|
        over_minutes+=over_h.hours*60
      end
      work_hours=(work_minutes/60).to_i
      holiday_hours=(holiday_minutes/60).to_i
      over_hour=(over_minutes/60).to_i

      work_minutes=(work_minutes-work_hours*60).to_i
      holiday_minutes=(holiday_minutes-holiday_hours*60).to_i
      over_minutes=(over_minutes-over_hour*60).to_i

      hours=[]
      hours[0]=work_hours.to_s+" hours and "+work_minutes.to_s+" minutes"
      hours[1]=holiday_hours.to_s+" hours and "+holiday_minutes.to_s+" minutes"
      hours[2]=over_hour.to_s+" hours and "+over_minutes.to_s+" minutes "
      hours
    end

end
