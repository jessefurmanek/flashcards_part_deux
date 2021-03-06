require_relative 'database.rb'

class Card
  attr_accessor :name, :front, :back, :mark_correct, :mark_incorrect,
  :last_reviewed, :interval, :save, :as_json

  def initialize(name)
    @name = name
    @front = ""
    @back = ""
    @last_reviewed = Time.now
    @interval = 1200
  end

  def mark_correct
    @interval*=2
  end

  def mark_incorrect
    @interval*=0.5
  end

  def save
    Database.save_card(self)
  end

  def to_hash
    h ={}
    h['name'] = @name
    h['front'] = @front
    h['back'] = @back
    h['last_reviewed'] = @last_reviewed
    h['interval'] = @interval
    h
  end
end
