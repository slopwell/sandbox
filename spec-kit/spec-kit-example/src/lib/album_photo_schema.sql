-- SQLite schema for albums and photos metadata
CREATE TABLE IF NOT EXISTS albums (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date TEXT NOT NULL,
  title TEXT,
  order_index INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS photos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  album_id INTEGER NOT NULL,
  file_path TEXT NOT NULL,
  thumbnail_path TEXT,
  metadata TEXT,
  FOREIGN KEY(album_id) REFERENCES albums(id)
);
