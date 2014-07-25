class HoursPlan < ActiveRecord::Base
	belongs_to :user
	validate :start_date ,:end_date ,presence: true
	validate :start_date_must_be_before_end_date
	validate :date_must_be_the_same_end_date

 	def start_date_must_be_before_end_date
    errors.add(:start_date, "must be before end date") unless 
      start_date < end_date
 	end

 	def date_must_be_the_same_end_date
    	errors.add(:end_date, "must be in the same day as start") unless
       start_date.strftime("%Y %m %d") == end_date.strftime("%Y %m %d")  
	end

end
