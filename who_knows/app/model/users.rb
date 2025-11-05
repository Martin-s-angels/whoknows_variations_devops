
Dotenv.load(__dir__ + '../dotenv/.env') #load .env from path


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
    db = SQLite3::Database.new(__dir__ + '../../db/whoknows.db')

    #db query
    query = "SELECT * FROM users WHERE username = " + username
    row = db.get_first_row(query)

    if row
        #id, username, email, password = row [id, username, email, password]
        puts ("row: " + row)

    else
        #[nil, nil, nil, nil]
        puts ("no row")
    end
end
