require 'erb'
require 'sinatra'
require_relative '../model/search.rb'
require 'json'
require 'sqlite3'
require __dir__ + '/../model/users.rb'

Dotenv.load('../who_knows/.dotenv/.env') #load .env from path #martins note: a .env (environment) file is a plain text file used to store configuration settings, such as API keys, database credentials, or secret tokens. These files house environment variables—dynamic values that influence how your application behaves across different environments (e.g., development, staging, production). in this context i use the env file to store the base url for our app. in develepment it should just be localhoset but i do not wish for our site with ip to be stored here so there i put it into the env file which is also created in the workflow file and sent to the server. so on githb we have a secret with our base url which then gets put into a env file and sent to the server on releases. 
base_url = ENV["BASE_URL"] #so here i load the base_url from the env file and input it into a varriable which i call base_url which i am gonna use thoughout the controller and that is why it is in this scope since i thought it  could be used in more then just one root or endpoint depending on the termonology one wish to use. however it is important 
set :port, 8080
#SERVE HTML PAGES:

get '/' do # this is the standard root of our page this is where the anyone who clicks on our link lands. this is also called a route or a endpoint. it is customary to have end points setup in this way with / as the first however some may disagree on the order of endpoints but in this instance it makes sense
  query = params['q'] # request parameter #martin note: request parameters we intake from the page. argo those parameters that the use inputs into the search when the sreach is made and the http request is then sendt to this controller in the backend which then unpacks the request parameter and puts them into the varriable of query which is just the search the user wishes to make 

  if query && !query.empty? #this is a if statment, or a if block to some. if's are stuckered in such a way that they first intake a statement and checks if that stements is subsequesnly is true, and then a code blcok runs defined in the if's scrope i check if query is present argo that it is not null or nullable like 0 or something like that, and i also check that it is not a empty string like this !query.empty? in case some just hits the seach button without having input anything and that could result in a empty string being parsed to the back end. 
    puts(base_url) # puts is a method that prints a output the the console, many similiar methods exist in pretty much all standard programming langugige, printf in c for example or system.out.print() in java functions the same way as puts. in this peticular puts methods i log base_URL which was defined higher up in the scope of this file. i did this to make sure it was present and my route would work since i did not wish to expose our url that our backend was running on on our port and ip so i therefore set it up like this for secuity reasons. 
    puts "baseURL = #{ENV['BASE_URL']}" #another puts which in many ways does the exact same thing as the one above it however this one was made for a alternative perpuse then the one above. the one above test rather the varriable base_url has anything in it. this one makes sure that we can load from the env file. so much the same but it was to discover why it came out as nothing when i ran the app on my local machine i later made the discovery that it was the load from env that was the problem but at time of writing the issue has been fixed and should not reppear so these lines can and should be delete and some point in the not so far future 

    result = HTTParty.get(base_url + "/api/search", query: { q: query }) #in this line i do serverl things of high importance for the funcunality of the code i shall break this down into serveral elements but not based on importants but rather the natural order when reading the code from left to right. what happens firt on this line is instanceiate a varriable called result i then define that to be the return value of httpParty which is a response. HTTParty is like a fetch in my understanding and therefor returns a responsebody which is the content from our api/seach route which returns the seach content. with this "fetch call" to our api/seach route i send a query much like this search functions gets. and so i simply pass the sreach from this endpoint to the next with a qury, this may not be the best option but it works but it could be improved further and may not be necessey. 
    puts "output for httparty was : #{result}" # yet another puts in the code block then one however has finally nothing to do with the base_url issue but relates to another issue i stuggled with for a very long time and remained unsolved for the majority of my time with the HttpParty and that was that no matter what i did HttpParty never returned anything after it hit our /api/seach route which was highly problematik and so i decided to log the output to force it to confess. however the code was silent for a very long time until after many long hours of invistiagtion it finally spoke up and told the truth which was a problem in the model class which i shall discuss when we get to that part of the code however i am writing this from top to button. 
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


