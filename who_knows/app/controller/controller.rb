require 'erb'
require 'sinatra'



Dotenv.load('../who_knows/dotenv/.env') #load .env from path
base_url = ENV["BASE_URL"]
set :port, 8080

#SERVE HTML PAGES:


get '/' do
  query = params['q'] # request parameter
  

  #puts "q=" + query #print variable in console. remove later.
  #query #remove. Test test.

  # serve root page
  result = HTTParty.get(base_url + "/api/search")

  seach_results =JSON.parse(result.body)
  
  erb :search, locals: {query: query, search_results: seach_results}
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


