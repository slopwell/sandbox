package api

import org.springframework.web.bind.annotation.*
import org.springframework.http.ResponseEntity
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import models.Book
import models.Author
import services.BookService

data class BookRequest(
    val title: String,
    val price: Int,
    val status: String,
    val authors: List<AuthorRequest>
)

data class AuthorRequest(
    val id: Long?,
    val name: String,
    val birthdate: String
)

@RestController
@RequestMapping("/books")
class BookApi @Autowired constructor(
    private val bookService: BookService
) {
    @PostMapping
    fun createBook(@RequestBody req: BookRequest): ResponseEntity<Book> {
        val authors = req.authors.map {
            Author(
                id = it.id,
                name = it.name,
                birthdate = java.time.LocalDate.parse(it.birthdate)
            )
        }
        val book = bookService.createBook(req.title, req.price, req.status, authors)
        return ResponseEntity.status(HttpStatus.CREATED).body(book)
    }

    @GetMapping("/{id}")
    fun getBook(@PathVariable id: Long): ResponseEntity<Book> {
        val book = bookService.getBook(id)
        return if (book != null) ResponseEntity.ok(book) else ResponseEntity.notFound().build()
    }

    @PutMapping("/{id}")
    fun updateBook(@PathVariable id: Long, @RequestBody req: BookRequest): ResponseEntity<Book> {
        val authors = req.authors.map {
            Author(
                id = it.id,
                name = it.name,
                birthdate = java.time.LocalDate.parse(it.birthdate)
            )
        }
        val book = bookService.updateBook(id, req.title, req.price, req.status, authors)
        return ResponseEntity.ok(book)
    }

    @DeleteMapping("/{id}")
    fun deleteBook(@PathVariable id: Long): ResponseEntity<Void> {
        val deleted = bookService.deleteBook(id)
        return if (deleted) ResponseEntity.noContent().build() else ResponseEntity.notFound().build()
    }

    @GetMapping
    fun listBooks(): ResponseEntity<List<Book>> = ResponseEntity.ok(bookService.listBooks())
}
