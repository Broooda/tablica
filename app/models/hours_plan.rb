class HoursPlan < ActiveRecord::Base
	belongs_to :user
	validates :start_date ,:end_date ,presence: true
	validate :start_date_must_be_before_end_date
	validate :date_must_be_the_same_end_date

 	def start_date_must_be_before_end_date
    errors.add(:start_date, "must be before end date") unless 
      self.start_date < self.end_date
 	end

 	def date_must_be_the_same_end_date
    	errors.add(:end_date, "must be in the same day as start") unless
       self.start_date.strftime("%Y %m %d") == self.end_date.strftime("%Y %m %d")  
	end

  def self.most_people_at_the_same_time(from, to)
    ret = {max_people: 0, people: nil, time: nil}

    starts = HoursPlan.where('start_date >= :from and start_date <= :to',{ from: from, to: to}).order('start_date')
    starts.each do |start|
      people_at_work = HoursPlan.where('start_date <= :this_time and end_date >= :this_time',{this_time: start.start_date}).order('surname')
      if people_at_work.size > ret[:max_people]
        ret = {max_people: people_at_work.size, people: people_at_work, time: start.start_date}
      end
    end

    ret
  end

end
