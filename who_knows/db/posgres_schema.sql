CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  username TEXT NOT NULL UNIQUE,
  email TEXT NOT NULL UNIQUE,
  pw_hash TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS pages (
    id SERIAL PRIMARY KEY,
    title TEXT not NULL,
    url TEXT NOT NULL UNIQUE,
    language TEXT NOT NULL DEFAULT 'en' CHECK (language IN ('en', 'da')),
    last_updated TIMESTAMP,
    content TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS pages_not_Found (
    id SERIAL PRIMARY KEY,
    qury TEXT not NULL
);
