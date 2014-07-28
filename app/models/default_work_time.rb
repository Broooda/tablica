#coding UTF-8

# Validator sprawdzający wilekość tablicy. Array 5 elementowy, zawierający arraye 2 elementowe
class WeekValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:week] << "Must have 5 days" unless record.week.length==5
    record.week.each { |day| record.errors[:week] << "Day #{Hash[record.week.map.with_index.to_a][day]+1} must start and end" unless day.length==2 }
    #record.week.each { |day| record.errors[:week] << "Day #{Hash[record.week.map.with_index.to_a][day]+1} has wrong format" unless day[0].class=Time.now.class? && day[1].class=Time.now.class? }
  end
end


class DefaultWorkTime < ActiveRecord::Base

  #pola: tablica arraów
  validates_with WeekValidator
  validates :user_id, presence: true

  belongs_to :user

  def self.generate_hours_plans(week=1, force_update=false)
    #funkcja generuje hours_plans
    #week (int) oznacza dla którego tygodnia ma wygenerować ( 0=dla aktualnego tygodnia, 1=dla następnego, -1=dla poprzedniego itd)
    #force_update (bool) - jesli sa jakiej godziny juz w tych dniach i force_update==true to napisze je 

    #poniedzialek 0:00 (posluzy jako punkt odniesienia)
    monday_midnight_in_current_week = DateTime.commercial(DateTime.now.year, DateTime.now.cweek,1)

    #iteruj po wszystkich DefaultWorkTime
    default_work_times = DefaultWorkTime.all
    default_work_times.each do |default_work_time|
      #dla kazdego dnia (pon-pt)
      day_num = 0;
      default_work_time.week.each do |day|
        #odziel godziny i miunuty z formatu (GG:MM)
        start_hour = day[0].split(':')
        end_hour = day[1].split(':')

        #pobierz aktualne godziny w tym dniu
        hours_in_that_day = HoursPlan.where(
          'user_id = ? and start_date > ? and start_date < ?',
          default_work_time.user_id,
          monday_midnight_in_current_week + week.week + day_num.day,
          monday_midnight_in_current_week + week.week + day_num.day + 1.day
          )

        #jesli sa jakies ogdziny i force_update to usun je
        if hours_in_that_day.size>0 and force_update
          hours_in_that_day.destroy_all
        end

        #jesli nie ma godzin lub force_update to dodaj nowe godziny
        if hours_in_that_day.size==0 or force_update
          HoursPlan.create(
            start_date: monday_midnight_in_current_week + week.week + day_num.day + start_hour[0].to_i.hour + start_hour[1].to_i.minute,
            end_date: monday_midnight_in_current_week + week.week + day_num.day + end_hour[0].to_i.hour + end_hour[1].to_i.minute,
            user_id: default_work_time.user_id
            )
        end
      day_num += 1;
      end
    end
  end
end






