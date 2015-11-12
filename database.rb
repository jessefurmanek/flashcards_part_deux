require 'json'

class Database
  JSON_FILE = 'flashcards.json'
  @@as_hash = {}

  def self.as_hash
    @@as_hash
  end

  def self.save_card(card)
    @@as_hash['deck'][card.name] = card
  end

  def self.update
    save_to_json_file
  end

  def self.save_to_json_file
    hash_as_json = hash_to_json
    File.open(JSON_FILE,"w") do |f|
      f.write(hash_as_json)
    end
  end

  def self.hash_to_json
    h = @@as_hash['deck']
    json_hash = {'deck'=>{}}
    h.each_key do |key|
      card_as_hash = h[key].to_hash
      json_hash['deck'][key] = card_as_hash
    end
    json_hash.to_json
  end

  def self.cards_as_array
    h = @@as_hash['deck']
    cards_as_array = []
    h.each_key do |key|
      cards_as_array<<h[key]
    end
    cards_as_array
  end

  def self.load_json_file_and_save_as_hash
    json_file = File.read(JSON_FILE)
    @@as_hash = JSON.parse(json_file)
  end

  def self.update_last_reviewed(card_name)
    @@as_hash['deck'][card_name]['last_reviewed'] = Time.now
  end

  def self.mark_card_correct(card_name)
    @@as_hash['deck'][card_name]['interval']*=2
  end

  def self.mark_card_incorrect(card_name)
    @@as_hash['deck'][card_name]['interval']*=0.5
  end
end
