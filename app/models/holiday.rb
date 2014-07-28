class Holiday < ActiveRecord::Base
  belongs_to :user
  validates :startdate, :enddate, :description, :user_id,  presence: true
  validates :status, :inclusion => { :in => %w(accepted rejected pending), message: "It should be accepted, rejected or pending" }
  validates :description, :reason, length: { maximum: 500 } 
  validate :start_date_must_be_before_end_date ,:presence => { :message => "start date must be erier before end date" }


private
		def start_date_must_be_before_end_date
    	errors.add(:startdate, "must be before end date") unless 
 		self.startdate < self.enddate
 		end
end