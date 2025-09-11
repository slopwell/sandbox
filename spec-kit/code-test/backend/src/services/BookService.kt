package services

import models.Book


import models.Validation

class BookService {
    private val books = mutableListOf<Book>()
    private var nextId = 1L

    fun createBook(title: String, price: Int, status: String, authors: List<Author>): Book {
        require(Validation.validateBook(price, authors, status)) { "書籍バリデーションエラー" }
        val book = Book(id = nextId++, title = title, price = price, status = status, authors = authors)
        books.add(book)
        return book
    }

    fun getBook(id: Long): Book? = books.find { it.id == id }

    fun updateBook(id: Long, title: String, price: Int, status: String, authors: List<Author>): Book {
        val idx = books.indexOfFirst { it.id == id }
        if (idx == -1) throw NoSuchElementException("Book not found")
        val old = books[idx]
        require(Validation.validateBook(price, authors, status, old.status)) { "書籍バリデーションエラー" }
        val updated = old.copy(title = title, price = price, status = status, authors = authors)
        books[idx] = updated
        return updated
    }

    fun deleteBook(id: Long): Boolean = books.removeIf { it.id == id }

    fun listBooks(): List<Book> = books.toList()
}
