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
      card = Card.new(csv_obj['name'])
      card.front = csv_obj['front']
      card.back = csv_obj['back']
      card.save
    end

    Database.save_to_json_file

  end

end
