class Holiday < ActiveRecord::Base
  belongs_to :user
  validates :startdate, :enddate, :description, :status, :reason, presence: true
  validates :status, :inclusion => { :in => %w(accepted rejected embing), message: "It should be accepted, rejected or embing" }
  validates :description, :reason, length: { maximum: 500 }
end
