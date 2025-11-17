require 'erb'
require 'sinatra'
require_relative '../model/search.rb'
require 'json'
require 'sqlite3'
require __dir__ + '/../model/users.rb'

Dotenv.load('../who_knows/.dotenv/.env') #load .env from path
base_url = ENV["BASE_URL"]
set :port, 8080
#SERVE HTML PAGES:


get '/' do
  query = params['q'] # request parameter

  if query && !query.empty?
    puts(base_url)
    puts "baseURL = #{ENV['BASE_URL']}"

    result = HTTParty.get(base_url + "/api/search", query: { q: query })
    puts "output for httparty was : #{result}"
    search_results = JSON.parse(result.body)

    erb :search, locals: { query: query, search_results: search_results }
  else
    erb :search, locals: { query: nil, search_results: [] }
  end
end


get '/register' do
  #serve register page
  erb :register, locals: { error: nil }

end

get '/login' do
  #serve login page

  #user1 = Users.new(1,"hej", "hej", "hej")#remove

  erb :login, locals: {error: nil}

end

#API'S
get '/api/search' do
  query = params['q'] # request parameter
  result = search(query)
  puts "output search function was: #{result}"
  result.to_json
  
  #search
end

get '/api/weather' do
  #weather. later.
end

post '/api/register' do
  #register
  username = params['username']
  email = params['email']
  password = params['password']
  password2 = params['password2']
  
  error = nil

  if !username || username.empty?
    error = 'You have to enter a username'
  elsif !email || email.empty? || !email.include?('@')
    error = 'You have to enter a valid email address'
  elsif !password || password.empty?
    error = 'You have to enter a password'
  elsif password != password2
    error = 'The two passwords do not match'
  elsif get_user(username)
    error = 'The username is already taken'
  elsif get_user_by_email(email)
    error = 'The email address is already in use'
  else
    add_user(username, email, password)
    # flash 'successfully registered'
    redirect '/login'
  end
  # If there was an error, re-render the register page with the error message
  erb :register, locals: { error: error }
end

post '/api/login' do
  username = params['username']
  password = params['password']
  
  error = nil

  #get user from db.
  user = get_user(username)

  #if user is nil
  if !user
    error = 'Invalid username'
  elsif !user.password_valid?(password) #password invalid
    error = 'Invalid password'
  else
    #flash: "succesfully logged in as (username)"
    #login. Set user in session.
    redirect "/", 303
  end

  erb :login, locals: { error: error }
end

get '/api/logout' do
  #logout.
end


