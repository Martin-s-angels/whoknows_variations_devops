# frozen_string_literal: true

require 'sinatra'
require 'httparty'
require 'dotenv'

Dotenv.load("#{__dir__}/../../dotenv/.env") # load .env from path

def fetch_weather
  api_key = ENV['WEATHER_API_KEY']
  return nil unless api_key

  city = 'Copenhagen' # You might want to make this dynamic later
  # Changed to forecast.json and requesting 7 days of data
  url = "http://api.weatherapi.com/v1/forecast.json?key=#{api_key}&q=#{city}&days=7&aqi=no&alerts=no"

  puts "Fetching weather from: #{url}"

  begin
    response = HTTParty.get(url)
    if response.success?
      JSON.parse(response.body)
    else
      puts "Weather API error: HTTP #{response.code}"
      puts "Response body: #{response.body}"
      nil
    end
  rescue StandardError => e
    puts "HTTP Request failed: #{e.message}"
    nil
  end
end