require_relative 'card'


class Review
  def self.run
    review_deck = load_review_deck
    review_cards(review_deck)
  end

  def self.load_review_deck
    review_deck = create_review_deck(Card.all)
  end

  def self.review_cards(review_deck)
    review_deck.each do |card|
      system "clear" or system "cls"
      puts card.front
      pause_and_press_enter_to_continue
      puts card.back
      puts
      while true
        answer = get_y_n_input
        if valid_y_n_input(answer)
          update_card_in_database(answer, card)
          break
        else
          puts "Invalid input -- try again!"
        end
      end
    end
  end

  def self.get_y_n_input
    print "Did you get it right? (Y/N)"
    answer = gets.chomp
  end

  def self.valid_y_n_input(answer)
    if ["Y", "YES", "N", "NO"].include?(answer.upcase)
      true
    else
      false
    end
  end

  def self.pause_and_press_enter_to_continue
    puts
    puts "Guess the answer and hit enter to continue"
    gets.chomp
    puts
  end

  def self.update_card_in_database(answer, card)
    if ["Y", "YES"].include?(answer.upcase)
      card.mark_correct
    else
      card.mark_incorrect
    end
      card.update_last_reviewed
  end

  def self.create_review_deck(cards)
    review_deck = []
    cards.each do |card|
      review_deck<<card if time_to_review?(card)
    end
    review_deck
  end

  def self.time_to_review?(card)
    card.last_reviewed+card.interval <= DateTime.now.iso8601
  end
end
