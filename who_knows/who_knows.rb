require 'sinatra'
require 'json'
require 'erb'

set :port, 8080
#set :settings.root, "./../"
#set :root, File.dirname(__FILE__)
#set :views, settings.root

set :views, "app/src/view"

puts "Views: " << String(settings.views)

get '/' do
    # content_type :json
    # {message: "Hello Frank!"}.to_json

    x = 42

    #erb "<%= foo %>", :locals => {:foo => "bar", :x => x}
    #erb "<%= x %>", :locals => {:x => x}

    #erb :'templates/erb-example.html', :locals => {:foo => "bar", :x => x}
    erb :'templates/erb-example.html', :locals => {foo: "bar",
                                                   x: x}

end

