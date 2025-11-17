#To run this file with sqlite: bundle exec ruby queries.rb 
#Make sure to have 
require 'sqlite3'
require 'dotenv/load'
require 'bcrypt'

Dotenv.load('../dotenv/.env') #load .env from path

Page = Struct.new(:id, :title, :language, :content) #??

begin
  db = SQLite3::Database.new "whoknows.db"

  #insert default user. (On test db)
  def insert_user_query(db)
    username = ENV['TEST_USERNAME']
    email    = ENV['TEST_EMAIL'] #unique
    password = ENV['TEST_PASSWORD']
    pw_hash = BCrypt::Password.create(password)

    query = "INSERT INTO users (username, email, pw_hash) VALUES (?,?,?)"
    db.execute(query,[username, email, pw_hash]) #run query
    db.last_insert_row_id #Auto increment
  end

  # def get_user_id_query(db)
  #   query = "SELECT id FROM users WHERE id = '1'"
  #   row = db.get_first_row(query) #only get first row
  #   if row
  #     id, username, email, pw_hash = row
  #     [id, username, email, pw_hash]
  #   else
  #     [nil, nil, nil, nil]
  #   end
  # end

  def get_user_by_id_query(db)
    query = "SELECT * FROM users WHERE id = '1'"
    row = db.get_first_row(query)
    if row
      id, username, email, password = row
      [id, username, email, password]
    else
      [nil, nil, nil, nil]
    end
  end

  def get_user_by_username_query(db)
    query = "SELECT * FROM users WHERE username = 'johndoe'"
    row = db.get_first_row(query)
    if row
      id, username, email, password = row
      [id, username, email, password]
    else
      [nil, nil, nil, nil]
    end
  end

  def search_pages_query(db)
    query = "SELECT * FROM pages WHERE language = 'en' AND content LIKE '%golang%'"
    pages = []
    db.execute(query) do |row|
      id, title, language, content = row
      pages << Page.new(id, title, language, content)
    end
    pages
  end

### run methods:

  last_id = insert_user_query(db)
  if last_id
    puts "InsertUserQuery: Inserted user with id #{last_id}"
  else
    puts "InsertUserQuery error"
  end

  user_id = get_user_id_query(db)
  if user_id
    puts "GetUserIDQuery: User 'johndoe' has id #{user_id}"
  else
    puts "GetUserIDQuery error"
  end

  id, username, email, pw_hash = get_user_by_id_query(db)
  if id
    puts "GetUserByIDQuery: id=#{id} username=#{username} email=#{email} pw_hash=#{pw_hash}"
  else
    puts "GetUserByIDQuery error"
  end

  id, username, email, pw_hash = get_user_by_username_query(db)
  if id
    puts "GetUserByUsernameQuery: id=#{id} username=#{username} email=#{email} pw_hash=#{pw_hash}"
  else
    puts "GetUserByUsernameQuery error"
  end

  pages = search_pages_query(db)
  if pages
    pages.each do |page|
      puts "SearchPagesQuery: id=#{page.id} title=#{page.title} language=#{page.language} content=#{page.content}"
    end
  else
    puts "SearchPagesQuery error"
  end

rescue SQLite3::Exception => e
  puts "Database error: #{e}"
ensure
  db.close if db #close db.
end