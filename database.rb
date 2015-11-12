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

  def self.load_json_file_and_save_as_hash
    json_file = File.read(JSON_FILE)
    @@as_hash = JSON.parse(json_file)
  end
end
