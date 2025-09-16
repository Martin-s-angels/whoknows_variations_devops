#set :port, 8080

#SERVE HTML PAGES:
get '/' do
  "Hello World #{params[:name]}".strip #testing rack-test. REMOVE.

  # serve root page
end

get '/weather' do
  #serve weather page. later.
end

get '/register' do
  #serve register page
end

get '/login' do
  #serve login page
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


