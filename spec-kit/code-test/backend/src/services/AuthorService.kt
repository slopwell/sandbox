package services


import models.Validation

class AuthorService {
    private val authors = mutableListOf<Author>()
    private var nextId = 1L

    fun createAuthor(name: String, birthdate: java.time.LocalDate, books: List<models.Book> = emptyList()): Author {
        require(Validation.validateAuthor(birthdate)) { "生年月日は現在より過去でなければなりません" }
        val author = Author(id = nextId++, name = name, birthdate = birthdate, books = books)
        authors.add(author)
        return author
    }

    fun getAuthor(id: Long): Author? = authors.find { it.id == id }

    fun updateAuthor(id: Long, name: String, birthdate: java.time.LocalDate, books: List<models.Book> = emptyList()): Author {
        val idx = authors.indexOfFirst { it.id == id }
        if (idx == -1) throw NoSuchElementException("Author not found")
        require(Validation.validateAuthor(birthdate)) { "生年月日は現在より過去でなければなりません" }
        val updated = authors[idx].copy(name = name, birthdate = birthdate, books = books)
        authors[idx] = updated
        return updated
    }

    fun deleteAuthor(id: Long): Boolean = authors.removeIf { it.id == id }

    fun listAuthors(): List<Author> = authors.toList()
}
