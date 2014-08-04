# coding: UTF-8

class Holiday < ActiveRecord::Base
  belongs_to :user
  validates :startdate, :enddate, :description, :user_id, presence: true
  validates :status, :inclusion => { :in => %w(accepted rejected pending), message: "It should be accepted, rejected or pending" }
  validates :description, :reason, length: { maximum: 500 }
  validate :start_date_must_be_before_end_date

  private
  
  def start_date_must_be_before_end_date
    return false if self.startdate.blank? == true or self.enddate.blank? == true or description.blank? == true       
    errors.add(:startdate, "must be earlier before end date") unless
    self.startdate < self.enddate
  end
end