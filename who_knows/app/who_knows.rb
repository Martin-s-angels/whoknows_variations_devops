require 'sinatra'
require 'json'
require_relative '../db/schema'

set :port, 8080

get '/' do
    content_type:json
    {message: "Hello Frank!"}.to_json
end

get '/pages' do
  @pages = DB.execute("SELECT * FROM pages")
  erb :index
end

