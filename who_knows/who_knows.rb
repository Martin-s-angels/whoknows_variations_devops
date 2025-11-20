require 'sinatra'
require 'json'
require 'erb'
require 'dotenv/load'

require_relative 'app/controller/controller.rb'
require_relative 'app/model/weather.rb'

Dotenv.load("dotenv/.env")

set :port, 8080
set :views, "app/view/templates/"

get '/pages' do #?? remove.
  @pages = DB.execute("SELECT * FROM pages") 
  erb :index
end

get '/weather' do #move to controller.rb
  weather = fetch_weather
  error = nil

  unless weather
    error = "unable to fetch weather data"
  end
  erb :weather, locals: { weather: weather, error: error }
end
