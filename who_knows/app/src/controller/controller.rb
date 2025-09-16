require 'erb'

set :port, 8080

#SERVE HTML PAGES:
get '/' do
  # serve root page
  erb :'templates/home.html'

end

get '/weather' do
  #serve weather page. later.
  erb :'templates/weather.html'

end

get '/register' do
  #serve register page
  erb :'templates/register.html'

end

get '/login' do
  #serve login page
  erb :'templates/login.html'

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


