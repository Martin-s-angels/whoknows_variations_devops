
Dotenv.load(__dir__ + '/../dotenv/.env') #load .env from path


class Users
    attr_accessor :id, :name, :email, :password

    def initialize(id, name, email, password) #constructor
        @id = id
        @name = name
        @email = email
        @password = password
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

def get_user(username)
    #connect to db
    db = SQLite3::Database.new(__dir__ + '/../../db/whoknows.db') 
    
    #query string
    query = "SELECT * FROM users WHERE username = '" + username + "'" 

    #execute query
    begin
        result = db.get_first_row(query) 
        #puts ("row: " + row[1])
        return Users.new(result[0], result[1], result[2], result[3]) #construct user from result
    
    rescue SQLite3::exception #may throw sqlite3 exception, if username not found.
        return nil
    end
end
