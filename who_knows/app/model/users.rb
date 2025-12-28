require 'dotenv'
require 'bcrypt'
require_relative '../../db/connection'
Dotenv.load("#{__dir__}/../dotenv/.env")

class Users
  attr_accessor :id, :name, :email, :password_hash

  def initialize(id, name, email, password_hash)
    @id = id
    @name = name
    @email = email
    @password_hash = password_hash
  end

  def password_valid(password)
    BCrypt::Password.new(@password_hash) == password
  end
end

def get_user(username)
  sql = 'SELECT * FROM users WHERE username = $1'

  begin
    result = DB_CONN.exec_params(sql, [username])
    return nil if result.ntuples.zero?

    row = result[0]
    Users.new(row['id'], row['username'], row['email'], row['pw_hash'])
  rescue PG::Exception => e
    puts "Error in get_user: #{e}"
    nil
  end
end

def get_user_by_email(email)
  sql = 'SELECT * FROM users WHERE email = $1'

  begin
    result = DB_CONN.exec_params(sql, [email])
    return nil if result.ntuples.zero?

    row = result[0]
    Users.new(row['id'], row['username'], row['email'], row['pw_hash'])
  rescue PG::Exception => e
    puts "Error in get_user_by_email: #{e}"
    nil
  end
end

def add_user(username, email, password)
  pw_hash = BCrypt::Password.create(password)
  sql = 'INSERT INTO users (username, email, pw_hash) VALUES ($1, $2, $3)'

  begin
    DB_CONN.exec_params(sql, [username, email, pw_hash])
  rescue PG::Exception => e
    puts "Error in add_user: #{e}"
  end
end
