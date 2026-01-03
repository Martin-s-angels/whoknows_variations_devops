# frozen_string_literal: true

require 'sinatra'
require 'json'
require 'erb'
require 'dotenv/load'

require_relative 'app/controller/controller'
require_relative 'app/model/weather'

configure do
  set :protection, except: :host_authorization
  # Or if you want to keep all protections except host:
  # set :protection, except: [:host_authorization, :frame_options]
end

Dotenv.load('dotenv/.env')
disable :protection
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