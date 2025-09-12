require 'sinatra'
require 'json'
require 'dotenv/load'

set :port, 8080

get '/' do
    content_type:json
    {message: "Hello Frank!"}.to_json
end

puts "Connecting to database at #{ENV['DATABASE_URL']}"
puts "Using API key #{ENV['API_KEY']}"