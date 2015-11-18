require 'json'
require 'active_record'
require_relative 'card.rb'

class Database
  JSON_FILE = 'flashcards.json'
  @@as_hash = {}

  def self.as_hash
    @@as_hash
  end

  def self.card_objects_to_hash(cards)
    h = {}
    cards.each do |card|
      h[card.name]=card.to_hash
    end
    h
  end

  def self.cards_as_array
    cards_as_array = []
    @@as_hash.each_key do |key|
      cards_as_array<<@@as_hash[key]
    end
    cards_as_array
  end

  def self.update_last_reviewed(card_name)
    c = Card.find_by_name(card_name)
    c.update_last_reviewed
  end

  def self.mark_card_correct(card_name)
    c = Card.find_by_name(card_name)
    c.mark_correct
  end

  def self.mark_card_incorrect(card_name)
    c = Card.find_by_name(card_name)
    c.mark_incorrect
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
    h ={}
    cards.each do |card|
      h[card.name]=card.to_hash
    end
    h
  end

  def self.bootstrap_sql_db
    set_log_and_establish_connection_to_db
  end

  def self.set_log_and_establish_connection_to_db
    ActiveRecord::Base.logger = Logger.new(File.open('../db/database.log', 'w'))

    ActiveRecord::Base.establish_connection(
      :adapter  => 'sqlite3',
      :database => '../db/flashcards_app.sqlite3'
    )
  end

  def self.set_up_sql_db_schema
    ActiveRecord::Schema.define do
      unless ActiveRecord::Base.connection.tables.include? 'cards'
        create_table :cards do |table|
          table.column :name, :string
          table.column :front, :string
          table.column :back, :string
          table.column :last_reviewed, :datetime
          table.column :interval, :integer
        end
      end
    end
  end

end
