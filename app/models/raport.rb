class Raport < ActiveRecord::Base
	validate :date_begin,presence: true
  validate :user_id,presence: true
  validate :date_end, presence: true
  validate :holiday_hours, presence: true
  validate :work_hours, presence: true


  before_action :comparing_dates


	private

  def comparing_dates
   if self.date_begin.empty? == false or self.date_end.empty? == false
      else
      errors.add(:date_begin, "must be earlier before end date") unless 
      self.date_begin < self.date_end
    end
  end


		def comparing_dates
          	errors.add(:date_begin, "must be before end date") unless 
 		self.date_begin < self.date_end
    end

    #Raport.generate_raport(start_date, end_date, user_id)
    def self.generate_raport(start_date=Time.now-4.week, end_date=Time.now, user_id=1, current_user)

    # Raport.generate_raport(start_date, end_date, user_id)
    def self.generate_raport(start_date=Time.now-4.week, end_date=Time.now, user_id=1)
        work_days = HoursPlan.where(
          'user_id = ? and start_date > ? and start_date < ?',
          user_id,start_date.to_time,(end_date.to_time + 1.day)       
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
      
      Raport.create(user_id: current_user.id, holiday_hours: holiday_hours, work_hours: work_hours, date_begin: start_date, date_end: end_date)
      
    end
end
end