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
    monday_midnight_in_current_week = DateTime.commercial(DateTime.now.year, DateTime.now.cweek,1,0,0,0,'+2')
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
          _start= monday_midnight_in_current_week + week.week + day_num.day + start_hour[0].to_i.hour + start_hour[1].to_i.minute
          _end= monday_midnight_in_current_week + week.week + day_num.day + end_hour[0].to_i.hour + end_hour[1].to_i.minute
          _id= default_work_time.user_id

        #Sprawdzenie urlopow
          if Holiday.where('user_id = ? and startdate < ? and enddate > ? and status= ?',
              user_id = _id,
              _start,
              _end,
              'accepted'
            ).size > 0
          elsif (holiday=Holiday.where('user_id = :id and :start <= startdate and :end_h >= startdate and 
          :start <= enddate and :end_h >= enddate and status= :status',
          {
            id: _id,
            start: _start,
            end_h: _end,
            status: 'accepted'

          }
            )).size > 0
            HoursPlan.create(start_date: _start,end_date: holiday[0].startdate, user_id: _id)
            HoursPlan.create(start_date: holiday[0].enddate,end_date: _end, user_id: _id)       
          elsif (holiday=Holiday.where('user_id = :id and :start <= startdate and :end_h >= startdate and status= :status',
          {
            id: _id,
            start: _start,
            end_h: _end,
            status: 'accepted'
          }
          )).size > 0
            _end=holiday[0].startdate
             HoursPlan.create(start_date: _start,end_date: _end, user_id: _id)
          elsif (holiday=Holiday.where('user_id = :id and :start <= enddate and :end_h >= enddate and status= :status',
          {
            id: _id,
            start: _start,
            end_h: _end,
            status: 'accepted'
           }
            )).size > 0
            _start=holiday[0].enddate
            HoursPlan.create(start_date: _start,end_date: _end, user_id: _id)
         else
            HoursPlan.create(start_date: _start,end_date: _end, user_id: _id)
         end
        end
      day_num += 1;
      end
    end
  end
end






