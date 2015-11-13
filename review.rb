require_relative 'database.rb'


class Review
  def self.run
    review_deck = load_review_deck
    review_cards(review_deck)
  end

  def self.load_review_deck
    cards_array = Database.cards_as_array
    review_deck = create_review_deck(cards_array)
  end

  def self.review_cards(review_deck)
    review_deck.each do |card|
      system "clear" or system "cls"
      puts card['front']
      pause_and_press_enter_to_continue
      puts card['back']
      puts
      print "Did you get it right? (Y/N)"
      answer = gets.chomp
      update_card_in_database(answer, card['name'])
    end
  end

  def self.pause_and_press_enter_to_continue
    puts
    puts "Guess the answer and hit enter to continue"
    gets.chomp
    puts
  end

  def self.update_card_in_database(answer, card_name)
    if ["Y", "YES"].include?(answer.upcase)
      Database.mark_card_correct(card_name)
    else
      Database.mark_card_incorrect(card_name)
    end
    Database.update_last_reviewed(card_name)
    Database.update
  end

  def self.create_review_deck(cards_array)
    review_deck = []
    cards_array.each do |card_hash|
      review_deck<<card_hash if time_to_review?(card_hash)
    end
    review_deck
  end

  def self.time_to_review?(card_hash)
    Time.parse(card_hash['last_reviewed'])+card_hash['interval'] <= Time.now
  end
end
