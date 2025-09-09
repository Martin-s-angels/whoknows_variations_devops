require 'sinatra'
require 'json'
require 'erb'

set :port, 8080
#set :settings.root, "./../"
 set :root, File.dirname(__FILE__)
#set :views, settings.root

puts "Views: " << String(settings.views)

get '/' do
    # content_type :json
    # {message: "Hello Frank!"}.to_json


    erb "<%= foo %>", :locals => {:foo => "bar"}
    erb :'templates/weather.html'
end

