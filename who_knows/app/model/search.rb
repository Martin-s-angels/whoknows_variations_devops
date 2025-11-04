require 'sqlite3'
require 'dotenv/load'


def seach(query)
puts "Running search for: #{query}"
  #Page = Struct.new(:id, :title, :language, :content) #??

  db = SQLite3::Database.new '../who_knows/db/whoknows.db' #instantiate db
  sql = "SELECT * FROM pages WHERE language = 'en' AND content LIKE ?"
  pages = []
  db.execute(sql, "%#{query}%") do |row|
  id, title, language, content = row
      pages << {
      id: id,
      title: title,
      language: language,
      content: content
    }
  end
  puts "output was: #{pages}"
  pages
end


