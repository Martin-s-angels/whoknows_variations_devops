require 'dotenv'
require 'bcrypt'
require 'sqlite3'

Dotenv.load(__dir__ + '/../dotenv/.env') #load .env from path


class Users
    attr_accessor :id, :name, :email, :password_hash

    def initialize(id, name, email, password_hash) #constructor
        @id = id
        @name = name
        @email = email
        @password_hash = password_hash
    end
    def password_valid?(password)
        BCrypt::Password.new(self.password_hash) == password
    end
end

    

=begin #remove or fix later.
    def open_db_connection()
        db = SQLite3::Database.new(__dir__ + '../../db/whoknows.db')
        puts("connect to db")
    end

    def close_db_connection()
    end
=end

def isPasswordValid(password)
    # hashing stuff. use BCrypt.
  return true;
end

def get_user(username)
    #connect to db
    db = SQLite3::Database.new(__dir__ + '/../../db/whoknows.db') 
    
    #query string
    query = "SELECT * FROM users WHERE username = ?" 

    #execute query
    begin
        result = db.get_first_row(query, username) 
        #puts ("row: " + row[1])
        return nil unless result
        return Users.new(result[0], result[1], result[2], result[3]) #construct user from result
    
    rescue SQLite3::Exception => e
        puts "Error in get_user: #{e}"
        return nil
    ensure
        db.close if db
    end
end

def get_user_by_email(email)
    db = SQLite3::Database.new(__dir__ + '/../../db/whoknows.db')
    query = "SELECT * FROM users WHERE email = ?"
    begin
        result = db.get_first_row(query, email)
        return nil unless result
        return Users.new(result[0], result[1], result[2], result[3])
    rescue SQLite3::Exception => e
        puts "Error in get_user_by_email: #{e}"
        return nil
    ensure
        db.close if db
    end
end

def add_user(username, email, password)
    db = SQLite3::Database.new(__dir__ + '/../../db/whoknows.db')
    
    pw_hash = BCrypt::Password.create(password) # pw_hash
    query = "INSERT INTO users (username, email, pw_hash) VALUES (?, ?, ?)" # inserting the new user into the table and hashing the password 

    begin
        db.execute(query,[username, email, pw_hash])
    rescue SQLite3::Exception => e
        puts "Error in add_user: #{e}"
    ensure
        db.close if db
    end
end