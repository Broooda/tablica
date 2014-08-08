# coding: UTF-8

# Validator sprawdzający wilekość tablicy. Array 5 elementowy, zawierający arraye 2 elementowe
class WeekValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:week] << "Must have 5 days" unless record.week.length==5
    record.week.each { |day| record.errors[:week] << "Day #{Hash[record.week.map.with_index.to_a][day]+1} must start and end" unless day.length==2 }
  end
end

# 
class HoursValidator < ActiveModel::Validator
  def validate(record)
    record.week.each do |day|
      if not day[0].to_time && day[1].to_time
        record.errors[:week] << "Day #{Hash[record.week.map.with_index.to_a][day]+1} has no start or end hour"
      elsif day[0].to_time > day[1].to_time
        record.errors[:week] << "You can't leave before you come, dumbass! "
      end
    end
  end
end

class DefaultWorkTimeRequest < ActiveRecord::Base
  # pola: tablica arraów, string: description, string: status, string: reason
  validates_with WeekValidator
  validates_with HoursValidator
  validates :user_id, presence: true
  validates :description, presence: true
  validates :status, inclusion: {in: %w(pending accepted rejected)}

  belongs_to :user
end