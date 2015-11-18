require 'sinatra'
require 'sinatra/activerecord'

set :database_file, '../config/database.yml'

class Flashcards < Sinatra::Base
  register Sinatra::ActiveRecordExtension
end
