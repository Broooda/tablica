class Raport < ActiveRecord::Base
	validate :date_begin, :user_id, :date_end, :hours_worked, presence: true
	validate :comparing_dates
	validate :hours_worked ,:numericality => true


	private
		def comparing_dates
    	errors.add(:date_begin, "must be before end date") unless 
 		self.date_begin < self.date_end
    end
end
