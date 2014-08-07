# coding: UTF-8

class OverHour < ActiveRecord::Base
  #Pola: datetime: date, int: user_id, int: hours, string: description
  validates :date, :status, :user_id, :description, :hours, presence: true
 	validates :hours, numericality: { only_float: true }, presence: true
 	validates :description ,length: { minimum: 5 }

	belongs_to :user

end