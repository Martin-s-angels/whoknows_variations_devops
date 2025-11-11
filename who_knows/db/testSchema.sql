-- Clean up
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS pages;

-- Create tables
CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT NOT NULL UNIQUE,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL
);

-- Default user ('password' = MD5 hash)
INSERT INTO users (username, email, password) 
VALUES ('admin', 'keamonk1@stud.kea.dk', '5f4dcc3b5aa765d61d8327deb882cf99');

CREATE TABLE IF NOT EXISTS pages (
  title TEXT PRIMARY KEY UNIQUE,
  url TEXT NOT NULL UNIQUE,
  language TEXT NOT NULL CHECK(language IN ('en', 'da')) DEFAULT 'en',
  last_updated TIMESTAMP,
  content TEXT NOT NULL
);


INSERT INTO pages (title, url, language, last_updated, content) VALUES
  ('The Life of Fish', 'https://en.wikipedia.org/wiki/Fish', 'en', CURRENT_TIMESTAMP, 'Fish live in the water and breathe through gills. They come in many colors and sizes.');



