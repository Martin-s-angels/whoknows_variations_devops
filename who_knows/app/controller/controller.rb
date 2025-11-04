require 'erb'
require 'sinatra'
require 'json'

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
  


=begin
        """Logs the user in."""
    error = None
    user = query_db("SELECT * FROM users WHERE username = '%s'" % request.form['username'], one=True)
    if user is None:
        error = 'Invalid username'
    elif not verify_password(user['password'], request.form['password']):
        error = 'Invalid password'
    else:
        flash('You were logged in')
        session['user_id'] = user['id']
        return redirect(url_for('search'))
    return render_template('login.html', error=error)


    Sinatra::Request:0x0000020d971f7538
=end

  username = params['username']
  password = params['password']
  
  #get user from db.
  #user = Users.get_user()
  
  #if user is nil
  #if password invalid
  #else: login. Set user in session.

  #login

  redirect "/", 303
end

get '/api/logout' do
  #logout.
end


