# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

set :environment, "development"

#set :output, "cron_log.log"

# every 1.minute do
#  runner "DefaultWorkTime.generate_few_weeks"
# end

every :saturday, :at => '3am' do
  runner "DefaultWorkTime.generate_few_weeks"
end

  #every '0 2 31 * *' do
    # OD DateTime.now.to_date-4.week TO DateTime.now.to_date
 #   runner pdf_admin_view.pdf?utf8=%E2%9C%93&start="2014-09-01"&end="2014-09-30"&commit=Generate+Raport
  #end

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
