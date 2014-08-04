# coding: UTF-8

# Validator sprawdzający wilekość tablicy. Array 5 elementowy, zawierający arraye 2 elementowe
class WeekValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:week] << "Must have 5 days" unless record.week.length==5
    record.week.each { |day| record.errors[:week] << "Day #{Hash[record.week.map.with_index.to_a][day]+1} must start and end" unless day.length==2 }
  end
end


class DefaultWorkTime < ActiveRecord::Base
  
  include GeneratingHours

  # pola: tablica arraów
  validates_with WeekValidator
  validates :user_id, presence: true

  belongs_to :user


  def self.generate_few_weeks
      (0..10).each do |counter|
      DefaultWorkTime.generate_hours_plans(counter)
    end
  end
end






