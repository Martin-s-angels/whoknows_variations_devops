require 'pg'
require 'dotenv/load'

Dotenv.load('./dotenv/.env') if File.exist?('./dotenv/.env')

def db_conn
  return @db_conn if defined?(@db_conn) && @db_conn

  @db_conn = if ENV['DB_URI_PROD']
               PG.connect(ENV['DB_URI_PROD'])

             elsif ENV['DB_URI_DEV']
               PG.connect(ENV['DB_URI_DEV'])

             elsif ENV['DB_URI_TEST']
               PG.connect(ENV['DB_URI_TEST'])
             end
end
