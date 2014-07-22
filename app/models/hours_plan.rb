class HoursPlan < ActiveRecord::Base
	# belongs_to :user
	validate :start_date ,:end_date 
	# ,presence: true
end
