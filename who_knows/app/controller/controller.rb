require 'erb'
require 'sinatra'
require_relative '../model/search.rb'
require 'json'
require 'sqlite3'
require __dir__ + '/../model/users.rb'
require 'sinatra/flash'

Dotenv.load('../who_knows/.dotenv/.env') #environment variables.
base_url = ENV["BASE_URL"]

set :port, 8080
enable :sessions

#SERVE HTML PAGES:

get '/' do
  query = params['q'] # request parameter
  search_results = []

  logged_in = false;
  if session[:logged_in]
    logged_in = true
  end

  if query && !query.empty?
    puts(base_url)
    puts "baseURL = #{ENV['BASE_URL']}"

    result = HTTParty.get(base_url + "/api/search", query: { q: query })
    puts "output for httparty was : #{result}"
    search_results = JSON.parse(result.body)

    #erb :search, locals: { query: query, search_results: search_results, logged_in: false } #session[:logged_in] }
  else
    #erb :search, locals: { query: nil, search_results: [], logged_in: false}
  end

  puts("session: " + logged_in.inspect) # session[:logged_in].inspect)#remove
  erb :search, locals: { query: query, search_results: search_results, logged_in: logged_in } #session[:logged_in] }
end


get '/register' do
  #serve register page
  erb :register, locals: { error: nil, logged_in: false }

end

get '/login' do
  #serve login page

  erb :login, locals: {error: nil, logged_in: false }
end

#API'S
get '/api/search' do
  query = params['q'] # request parameter
  result = search(query)
  puts "output search function was: #{result}"
  result.to_json
  
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
    redirect '/'
  end
  # If there was an error, re-render the register page with the error message
  erb :register, locals: { error: error }
end

post '/api/login' do
  username = params['username']
  password = params['password']  

  user = get_user(username)   #db query.

  if user == nil #if no user.
    flash[:error] = 'Invalid username'

  elsif user.password_valid(password)  #password invalid
    flash[:error] = 'Invalid password'

  else #succesful
    session[:logged_in] = true
    flash[:succes] = "succesfully logged in as" + username
  end
  
  redirect "/", 303
end

get '/api/logout' do
  session[:logged_in] = false
  flash[:succes] = "succesfully logged out"

  redirect "/", 303
end


=begin 
get '/foo' do
  session[:message] = 'Hello World!'
  redirect to('/bar')
end

get '/bar' do
  session[:message]   # => 'Hello World!'
end

=end
