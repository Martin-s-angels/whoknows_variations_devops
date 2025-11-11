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
      pages << { #from the quryies file in the db  which i stole this block about how to make searches and redefined it here this does mean it exists twice but i was not sure that was acutally how we wanted it but i found out that the search function in qurries.rb file did not work so therefore i made this block with a subtle but important differance, in the qurries.rb the method uses a sturct which i have no idea how works in ruby and it would not no matter what i did convert to a json. so instead i did this on this current line where i instead define a key value pair pretty much exaclty the way json would be defined and it worked. i think this is actually a ruby object this but i am not certain about this but with this setup it converts without issue. there might be a reason to use sturct still that i am unaware of at this moment in time. 
      title: title,
      url: url,
      language: language,
      content: content
    }
  end
  puts "output was: #{pages}"
  pages
end


