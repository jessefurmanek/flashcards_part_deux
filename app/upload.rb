require 'csv'
require_relative 'card.rb'

class Upload
  def self.run
    filename = get_filename
    if File.exist?(filename)
      upload_deck(filename)
    else
      puts "File not found -- try again!"
      self.run
    end
  end

  def self.get_filename
    puts "What is the name of the file?"
    print "? "
    f = gets.chomp
  end

  def self.upload_deck(filename)
    CSV.foreach(filename, :headers => true) do |csv_obj|
      c = Card.create!(
        :name => csv_obj['name'],
        :front => csv_obj['front'],
        :back => csv_obj['back'],
        :last_reviewed => Time.now,
        :interval => 1200
      )
    end
  end
end
