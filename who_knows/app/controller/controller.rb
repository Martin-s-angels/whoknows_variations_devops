# frozen_string_literal: true

require 'erb'
require 'sinatra'
require_relative '../model/search'
require 'json'
require 'sqlite3'
require_relative '../model/users'
require_relative '../model/weather'
require_relative 'metrics'
require 'sinatra/flash'
require 'httparty'
require_relative '../../db/connection'

Dotenv.load('../../dotenv/.env') # environment variables.
base_url = ENV['BASE_URL']

set :port, 8080
set :public_folder, File.join(File.dirname(__FILE__), '../views/public')
enable :sessions

# SERVE HTML PAGES:

get '/' do
  query = params['q'] # request parameter
  search_results = []

  logged_in = false; # using the same variable names for erb, always
  logged_in = true if session[:logged_in]

  weather = begin
    fetch_weather
  rescue StandardError
    nil
  end # fetch weather

  if query && !query.empty?
    start_time = Time.now

    SEARCH_REQUESTS.increment
    puts "baseURL = #{ENV['BASE_URL']}"

    result = HTTParty.get("#{base_url}/api/search", query: { q: query })
    puts "output for httparty was : #{result}"

    search_results = JSON.parse(result.body)

    if search_results.empty?
      SEARCH_REQUESTS_NOT_FOUND.increment
      missing_search(query)
    else
      SEARCH_REQUESTS_FOUND.increment
    end

    SEACH_DURATION.observe(Time.now - start_time)
  end

  erb :search, locals: { query: query, search_results: search_results, logged_in: logged_in, weather: weather }
end

get '/register' do
  # serve register page
  erb :register, locals: { error: nil, logged_in: false }
end

get '/login' do
  # serve login page

  erb :login, locals: { error: nil, logged_in: false }
end

# API'S
get '/api/search' do
  query = params['q'] # request parameter
  result = search(query)
  puts "output search function was: #{result}"
  result.to_json
end

get '/weather' do
  weather = fetch_weather
  error = nil

  error = 'unable to fetch weather data' unless weather
  erb :weather, locals: { weather: weather, error: error, logged_in: session[:logged_in] }
end

get '/api/weather' do
  # weather. later.
end

post '/api/register' do
  # register
  username = params['username']
  email = params['email']
  password = params['password']
  password2 = params['password2']

  error = nil

  if !username || username.empty?
    error = 'You have to enter a username'
    AUTH_EVENTS.increment(labels: { event: 'register_attempt' })
  elsif !email || email.empty? || !email.include?('@')
    error = 'You have to enter a valid email address'
    AUTH_EVENTS.increment(labels: { event: 'register_attempt' })
  elsif !password || password.empty?
    error = 'You have to enter a password'
    AUTH_EVENTS.increment(labels: { event: 'register_attempt' })
  elsif password != password2
    error = 'The two passwords do not match'
    AUTH_EVENTS.increment(labels: { event: 'register_attempt' })
  elsif get_user(username)
    error = 'The username is already taken'
    AUTH_EVENTS.increment(labels: { event: 'register_attempt' })
  elsif get_user_by_email(email)
    error = 'The email address is already in use'
    AUTH_EVENTS.increment(labels: { event: 'register_attempt' })
  else
    add_user(username, email, password)
    AUTH_EVENTS.increment(labels: { event: 'register_success' })
    # flash 'successfully registered'
    redirect '/'
  end
  # If there was an error, re-render the register page with the error message
  erb :register, locals: { error: error }
end

post '/api/login' do
  username = params['username']
  password = params['password']
  AUTH_EVENTS.increment(labels: { event: 'login_attempt' })
  user = get_user(username) # db query.

  if user.nil? # if no user.
    flash[:error] = 'Invalid username'

    AUTH_EVENTS.increment(labels: { event: 'login_user_not_found' })

  elsif user.password_valid(password) == false # password invalid
    flash[:error] = 'Invalid password'

    AUTH_EVENTS.increment(labels: { event: 'login_bad_password' })

  else # succesful
    session[:logged_in] = true
    flash[:succes] = "Succesfully logged in as #{username}"
    AUTH_EVENTS.increment(labels: { event: 'login_success' })
    SESSIONS.increment(labels: { event: 'login' })
  end

  redirect '/', 303
end

get '/api/logout' do
  session[:logged_in] = false
  flash[:succes] = 'Succesfully logged out'
  SESSIONS.increment(labels: { event: 'logout' })
  redirect '/', 303
end

get '/about' do
  # serve about page
  erb :about
end
