
Dotenv.load(__dir__ + '/../dotenv/.env') #load .env from path


class Users
    attr_accessor :id, :name, :email, :password

    def initialize(id, name, email, password) #constructor
        @id = id
        @name = name
        @email = email
        @password = password

        puts ("initialize user") #remove
    end
end

    

=begin #remove or fix later.
    def self.connect_db()
        db = SQLite3::Database.new(__dir__ + '../../db/whoknows.db')
        puts("connect to db")
    end

    def self.close_db()
    end
=end

def get_user(username)

    puts("get_user")
    #puts("db path: " + __dir__ + '/../../db/whoknows.db')

    db = SQLite3::Database.new(__dir__ + '/../../db/whoknows.db') 

    #db query
    query = "SELECT * FROM users WHERE username = '" + username + "'"
    begin
        row = db.get_first_row(query)
        puts ("row: " + row[1])
    rescue Exception => e
        puts( "error: " + e.message)
        return "user not found"
    end

=begin
    if row
        #id, username, email, password = row [id, username, email, password]
        

    else
        #[nil, nil, nil, nil]
        puts ("no row")
    end
=end
end
