require 'sqlite3'
require 'dotenv/load'


def search(query)
puts "Running search for: #{query}"
  #Page = Struct.new(:id, :title, :language, :content) #??

  db = SQLite3::Database.new '../who_knows/db/whoknows.db' #instantiate db
  sql = "SELECT * FROM pages WHERE language = 'en' AND content LIKE ?"
  pages = []
  db.execute(sql, "%#{query}%") do |row|
    title, url, language, content = row
      pages << {
      title: title,
      url: url,
      language: language,
      content: content
    }
  end
  puts "output was: #{pages}"
  pages
end