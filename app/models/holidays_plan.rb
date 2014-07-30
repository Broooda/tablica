class HolidaysPlan < ActiveRecord::Base
      # integer :user_id,
      # t.integer :hours
      # t.datetime :holiday_date
    validates :hours , :holiday_date, :user_id, presence: true
    belongs_to :user
end