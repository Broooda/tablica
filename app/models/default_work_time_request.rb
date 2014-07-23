#coding UTF-8

# Validator sprawdzający wilekość tablicy. Array 5 elementowy, zawierający arraye 2 elementowe
class WeekValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:week] << "Must have 5 days" unless record.week.length==5
    record.week.each { |day| record.errors[:week] << "Day #{Hash[record.week.map.with_index.to_a][day]+1} must start and end" unless day.length==2 }
    #record.week.each { |day| record.errors[:week] << "Day #{Hash[record.week.map.with_index.to_a][day]+1} has wrong format" unless day[0].class=Time.now.class? && day[1].class=Time.now.class? }
  end
end

class DefaultWorkTimeRequest < ActiveRecord::Base
     #pola: tablica arraów, string: description, string: status
  validates_with WeekValidator
  validates :user_id, presence: true
  validates :description, presence: true
  validates :status, inclusion: {in: %w(pending accepted rejected)}

  belongs_to :user

end