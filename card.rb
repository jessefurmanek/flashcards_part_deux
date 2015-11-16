require_relative 'database.rb'
require 'active_record'

class Card < ActiveRecord::Base
  attr_accessor :mark_correct, :mark_incorrect, :as_json

  def mark_correct
    c = Card.find_by_id(self.id)
    c.interval*=2
    c.save
  end

  def mark_incorrect
    c = Card.find_by_id(self.id)
    c.interval*=0.5
    c.save
  end

  def update_last_reviewed
    c = Card.find_by_id(self.id)
    c.last_reviewed = DateTime.now.iso8601
    c.save
  end

  def to_hash
    h ={}
    h['name'] = self.name
    h['front'] = self.front
    h['back'] = self.back
    h['last_reviewed'] = self.last_reviewed
    h['interval'] = self.interval
    h
  end
end
