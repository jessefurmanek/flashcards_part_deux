require "sinatra/activerecord"

set :database_file, "path/to/database.yml"

class YourApplication < Sinatra::Base
  register Sinatra::ActiveRecordExtension
end
