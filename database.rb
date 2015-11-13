require 'json'
require 'active_record'
require_relative 'card.rb'

class Database
  JSON_FILE = 'flashcards.json'
  @@as_hash = {}

  def self.as_hash
    @@as_hash
  end

  # def self.save_card(card)
  #   name = card.name
  #
  #   Card.create(
  #     :name => card.name,
  #     :front => card.front,
  #     :back => card.back,
  #     :last_reviewed => card.last_reviewed,
  #     :interval => card.interval
  #   )
  # end

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

  def self.update_last_reviewed(card_name)
    @@as_hash['deck'][card_name]['last_reviewed'] = Time.now
  end

  def self.mark_card_correct(card_name)
    @@as_hash['deck'][card_name]['interval']*=2
  end

  def self.mark_card_incorrect(card_name)
    @@as_hash['deck'][card_name]['interval']*=0.5
  end

  def self.load_json_file_and_save_as_hash
    json_file = File.read(JSON_FILE)
    @@as_hash = JSON.parse(json_file)
  end

  def self.initialize_database
    load_sqldb_and_save_as_hash
  end

  def self.load_sqldb_and_save_as_hash
    bootstrap_sql_db
    set_up_sql_db_schema
    @@as_hash = get_db_as_hash
  end

  def self.get_db_as_hash
    cards = Card.all
  end

  def self.bootstrap_sql_db
    set_log_and_establish_connection_to_db
  end

  def self.set_log_and_establish_connection_to_db
    ActiveRecord::Base.logger = Logger.new(File.open('db/database.log', 'w'))

    ActiveRecord::Base.establish_connection(
      :adapter  => 'sqlite3',
      :database => 'db/flashcards_app.sqlite3'
    )
  end

  def self.set_up_sql_db_schema
    ActiveRecord::Schema.define do
      unless ActiveRecord::Base.connection.tables.include? 'cards'
        create_table :cards do |table|
          table.column :name, :string
          table.column :front, :string
          table.column :back, :string
          table.column :last_reviewed, :time
          table.column :interval, :integer
        end
      end
    end
  end

end
