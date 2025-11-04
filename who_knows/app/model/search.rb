
def seach(query)

  Page = Struct.new(:id, :title, :language, :content) #??

  db = SQLite3::Database.load 'whoknows.db' #instantiate db
  sql = "SELECT * FROM pages WHERE language = 'en' AND content LIKE ?"
  pages = []
  db.execute(sql, query) do |row|
  id, title, language, content = row
  pages << Page.new(id, title, language, content)
  end
  pages
end


