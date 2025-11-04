class Users
    attr_accessor :id, :name, :email, :password

    def initialize(id, name, email, password) #constructor
        @id = id
        @name = name
        @email = email
        @password = password

        puts ("initialize user")
    end

end

