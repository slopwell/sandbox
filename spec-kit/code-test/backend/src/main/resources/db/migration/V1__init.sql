-- Flyway初期化用スキーマ
CREATE TABLE author (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birthdate DATE NOT NULL
);

CREATE TABLE book (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    price INTEGER NOT NULL CHECK (price >= 0),
    status VARCHAR(16) NOT NULL
);

CREATE TABLE book_author (
    book_id INTEGER NOT NULL REFERENCES book(id),
    author_id INTEGER NOT NULL REFERENCES author(id),
    PRIMARY KEY (book_id, author_id)
);
