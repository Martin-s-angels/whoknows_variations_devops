require 'sinatra'
require 'json'
require 'erb'
require 'dotenv/load'

require_relative 'app/controller/controller.rb'
require_relative 'app/model/weather.rb'

Dotenv.load("dotenv/.env")

set :port, 8080
set :views, "app/view/templates/"

get '/test' do

  puts("Test release workflow. Remove this line")

  #test erb (remove later):
  x = 42

    #erb "<%= foo %>", :locals => {:foo => "bar", :x => x}
    #erb "<%= x %>", :locals => {:x => x}

    #erb :'templates/erb-example.html', :locals => {:foo => "bar", :x => x}



  # erb :'templates/layout.html', :locals => {foo: "bar", x: x}
  erb :index


    # active_html: File.new('./app/src/view/templates/erb-example.html.erb') }

  #erb :'templates/erb-example.html', :locals => {foo: "bar",
  #                                               x: x}


end

#test dotenv:
puts "Connecting to database at #{ENV['DATABASE_URL']}"
puts "Using API key #{ENV['API_KEY']}"

get '/pages' do
  @pages = DB.execute("SELECT * FROM pages")
  erb :index
end


get '/weather' do
  weather = fetch_weather
  error = nil

  unless weather
    error = "unable to fetch weather data"
  end
  erb :weather, locals: { weather: weather, error: error }
end
