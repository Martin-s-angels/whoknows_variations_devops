# frozen_string_literal: true

require 'sinatra'
require 'json'
require 'erb'
require 'dotenv/load'

require_relative 'app/controller/controller'
require_relative 'app/model/weather'

Dotenv.load('dotenv/.env')

set :port, 8080
set :views, 'app/views/templates/'

get '/pages' do # ?? remove.
  @pages = DB.execute('SELECT * FROM pages')
  erb :index
end

get '/weather' do # move to controller.rb
  weather = fetch_weather
  error = nil

  error = 'unable to fetch weather data' unless weather
  erb :weather, locals: { weather: weather, error: error }
end
