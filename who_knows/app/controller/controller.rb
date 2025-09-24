require 'erb'

#set :port, 8080

#SERVE HTML PAGES:
get '/' do
  query = params['q'] # request parameter

  puts "q=" + query #print variable in console. remove later.

  # serve root page
  erb :search

end

get '/weather' do
  #serve weather page. later.
  erb :weather

end

get '/register' do
  #serve register page
  erb :register

end

get '/login' do
  #serve login page
  erb :login

end

#API'S
get '/api/search' do
  #search
end

get '/api/weather' do
  #weather. later.
end

post '/api/register' do
  #register
end

post '/api/login' do
  #login
end

get '/api/logout' do
  #logout.
end


