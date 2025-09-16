require 'sinatra'
require 'json'
require 'erb'
require 'dotenv/load'

set :port, 8080
set :root, File.dirname(__FILE__)

puts "Views: " << String(settings.views) #trouble-shooting. Remove, probably.

get '/' do

  #test erb (remove later):
  x = 42

    #erb "<%= foo %>", :locals => {:foo => "bar", :x => x}
    #erb "<%= x %>", :locals => {:x => x}

    #erb :'templates/erb-example.html', :locals => {:foo => "bar", :x => x}
  erb :'templates/erb-example.html', :locals => {foo: "bar",
                                                 x: x}
end

#test dotenv:
puts "Connecting to database at #{ENV['DATABASE_URL']}"
puts "Using API key #{ENV['API_KEY']}"

