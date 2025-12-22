# frozen_string_literal: true

require_relative '../../db/connection'

def search(query)
  sql = "SELECT title, url, language, content FROM pages WHERE language = 'en' AND (title ILIKE $1 OR content ILIKE $1)"
  result = DB_CONN.exec_params(sql, ["%#{query}%"])

  result.map do |row|
    {
      title: row['title'],
      url: row['url'],
      language: row['language'],
      content: row['content']
    }
  end
end

def MissingSearch(query)
  sql = 'SELECT * FROM pages_not_found WHERE qury = $1'
  result = DB_CONN.exec_params(sql, [query])

  return unless result.ntuples == 0

  insert_sql = 'INSERT INTO pages_not_found (qury) VALUES ($1)'
  DB_CONN.exec_params(insert_sql, [query])
end
