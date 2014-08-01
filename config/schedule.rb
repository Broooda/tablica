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

# every '0 2 31 * *' do
#   runner "Mailer.send_friend_sheet"
# end

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
