
class Users
    attr_accessor :id, :name, :email, :password

    def initialize(id, name, email, password) #constructor
        @id = id
        @name = name
        @email = email
        @password = password

        puts ("initialize user") #remove
    end

    def get_user(name)
        #db query
        query = "SELECT * FROM users WHERE username = "
        row = db.get_first_row(query)
        if row
            id, username, email, password = row [id, username, email, password]
        else
            [nil, nil, nil, nil]
        end
    end


end

