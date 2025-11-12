require 'sinatra'
require 'httparty'
require 'dotenv'

Dotenv.load('../who_knows/.dotenv/.env') #load .env from path

def fetch_weather
  api_key = ENV['WEATHER_API_KEY'] #a problem: it refuses to fetch when the api is hidden in .env, but when written raw the data loads ????
  city = "Copenhagen"
  url = "http://api.weatherapi.com/v1/current.json?key=#{api_key}&q=#{city}&aqi=no"

  puts "api key #{url}"
  
  response = HTTParty.get(url)
  if response.success?
    JSON.parse(response.body)
  else
    puts "Weather API error: HTTP #{response.code}"
    puts "Response body: #{response.body}"
    nil
  end
end