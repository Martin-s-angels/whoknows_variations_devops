require 'erb'
require 'sinatra'
require_relative '../model/search.rb'




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
  erb :register

end

get '/login' do
  #serve login page
  erb :login

end

#API'S
get '/api/search' do
  query = params['q'] # request parameter
  result = seach(query)
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
  #login
end

get '/api/logout' do
  #logout.
end


