require 'sinatra'
require 'json'
require 'erb'
require 'dotenv/load'
require_relative 'app/src/controller/controller.rb'

set :port, 8080
set :views, "app/src/view"

#set :layout, :'app/src/view/templates/layout.html.erb'#File.new('app/src/view/templates/layout.html.erb')

puts "Views: " << String(settings.views)

get '/test' do

  #test erb (remove later):
  x = 42

    #erb "<%= foo %>", :locals => {:foo => "bar", :x => x}
    #erb "<%= x %>", :locals => {:x => x}

    #erb :'templates/erb-example.html', :locals => {:foo => "bar", :x => x}



  erb :'templates/example.html',
      :locals => {foo: "bar", x: x},
      :layout => :'templates/layout.html'


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

