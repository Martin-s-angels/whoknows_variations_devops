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
  sql = 'INSERT into pages_not_Found (qury) VALUES ($1)'
  DB_CONN.exec_params(sql, [query])
end
