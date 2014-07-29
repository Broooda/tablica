class Holiday < ActiveRecord::Base
  belongs_to :user
  validates :startdate, :enddate, :description, :user_id,  presence: true
  validates :status, :inclusion => { :in => %w(accepted rejected pending), message: "It should be accepted, rejected or pending" }
  validates :description, :reason, length: { maximum: 500 } 
  validates_with :start_date_must_be_before_end_date 



    private
		def start_date_must_be_before_end_date
			unless self.startdate.blank? == true or self.enddate.blank? == true or description.blank? == true
    		unless self.startdate < self.enddate
        errors.add(:startdate, "must be earlier before end date")  
 			  end
 		   end
 		end
end

