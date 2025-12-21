require 'pg'
require 'dotenv/load'
Dotenv.load('./dotenv/.env') # environment variables.

puts File.exist?('./dotenv/.env')

def db_conn
  @db_conn ||= PG.connect(ENV['DB_URI_DEV'])
end
