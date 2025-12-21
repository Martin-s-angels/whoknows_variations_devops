require 'pg'
require 'dotenv/load'
Dotenv.load('./dotenv/.env') # environment variables.

puts File.exist?('./dotenv/.env')

DB_CONN = PG.connect(ENV['DB_URI_DEV'])
