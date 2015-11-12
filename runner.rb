require_relative "card.rb"
require_relative "upload.rb"
require_relative "review.rb"

class Runner
  def self.bootstrap
    Database.initialize_database
  end

  def self.get_actions
    actions = ['Review Cards', 'Upload Cards']
  end

  def self.show_actions
    system "clear" or system "cls"
    actions = get_actions
    actions.each_with_index do |action, i|
      puts (i+1).to_s+") "+action
    end
  end

  def self.get_and_valididate_input
    input = get_input
    if !valid_input?(input)
      puts "Invalid selection! Try again."
      get_and_valididate_input
    else
      input
    end
  end

  def self.get_input
    puts
    print "? "
    user_input = gets.chomp
    user_input.to_i
  end

  def self.execute_action(input)
    case input
    when 1
      Review.run
    when 2
      Upload.run
    end
  end


  def self.valid_input?(input)
    actions = get_actions
    (1..actions.size).include?(input.to_i)
  end
end
