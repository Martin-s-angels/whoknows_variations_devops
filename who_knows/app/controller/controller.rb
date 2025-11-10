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

get '/' do # this is the standard root of our page this is where the anyone who clicks on our link lands. this is also called a route or a endpoint. it is customary to have end points setup in this way with / as the first however some may disagree on the order of endpoints but in this instance it makes sense
  query = params['q'] # request parameter #martin note: request parameters we intake from the page. argo those parameters that the use inputs into the search when the sreach is made and the http request is then sendt to this controller in the backend which then unpacks the request parameter and puts them into the varriable of query which is just the search the user wishes to make 

  if query && !query.empty? #this is a if statment, or a if block to some. if's are stuckered in such a way that they first i
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
  erb :register

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


