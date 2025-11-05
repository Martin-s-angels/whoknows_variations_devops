require 'erb'
require 'sinatra'
require 'json'
require 'sqlite3'


require __dir__ + '/../model/users.rb'

set :port, 8080

#SERVE HTML PAGES:


get '/' do
  query = params['q'] # request parameter

  #puts "q=" + query #print variable in console. remove later.
  #query #remove. Test test.

  # serve root page
  erb :search
end

get '/register' do
  #serve register page
  erb :register

end

get '/login' do
  #serve login page

  #user1 = Users.new(1,"hej", "hej", "hej")#remove

  erb :login, locals: {error: nil}

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
  username = params['username']
  password = params['password']
  
  error = nil

  #get user from db.
  user = get_user(username)

  #if user is nil
  if (!user)
    error = 'Invalid username'
  elsif (false) #password invalid
    error = 'Invalid password'
  else
    #flash: "succesfully logged in as (username)"
    #login. Set user in session.
  end

  redirect "/", 303
end

get '/api/logout' do
  #logout.
end


