require 'csv'
require './app/card'

filename = './db/ar.csv'

puts Dir.pwd
CSV.foreach(filename, :headers => true) do |csv_obj|
  Card.create!(
    :name => csv_obj['name'],
    :front => csv_obj['front'],
    :back => csv_obj['back'],
    :last_reviewed => Time.now,
    :interval => 1200
  )
end
