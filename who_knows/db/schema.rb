require 'sqlite3'

db = SQLite3::Database.new "my_app.db"

# Create users table
db.execute <<-SQL
CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT NOT NULL UNIQUE,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL
);
SQL

# Insert default user (MD5 password)
begin
  db.execute("INSERT INTO users (username, email, password) VALUES (?, ?, ?)", 
    ['admin', 'keamonk1@stud.kea.dk', '5f4dcc3b5aa765d61d8327deb882cf99'])
rescue SQLite3::ConstraintException
  # user already exists, ignore
end

# Create pages table
db.execute <<-SQL
CREATE TABLE IF NOT EXISTS pages (
  title TEXT PRIMARY KEY UNIQUE,
  url TEXT NOT NULL UNIQUE,
  language TEXT NOT NULL DEFAULT 'en' CHECK(language IN ('en','da')),
  last_updated TIMESTAMP,
  content TEXT NOT NULL
);
SQL
