# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

a=DefaultWorkTime.new
a.week=[['9:00','17:00'],['9:00','17:00'],['9:00','17:00'],['9:00','17:00'],['9:00','17:00']]
a.save
