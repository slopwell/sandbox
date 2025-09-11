package api

import org.springframework.web.bind.annotation.*
import org.springframework.http.ResponseEntity
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import models.Author
import models.Book
import services.AuthorService
import services.BookService

// BookApi.ktと同じAuthorRequestを利用
// BookRequest/AuthorRequestの定義は共通化も可能だが、ここでは個別定義

data class AuthorRequest(
    val id: Long?,
    val name: String,
    val birthdate: String
)

data class BookSimpleResponse(
    val id: Long?,
    val title: String,
    val price: Int,
    val status: String
)

@RestController
@RequestMapping("/authors")
class AuthorApi @Autowired constructor(
    private val authorService: AuthorService,
    private val bookService: BookService
) {
    @PostMapping
    fun createAuthor(@RequestBody req: AuthorRequest): ResponseEntity<Author> {
        val author = authorService.createAuthor(
            name = req.name,
            birthdate = java.time.LocalDate.parse(req.birthdate)
        )
        return ResponseEntity.status(HttpStatus.CREATED).body(author)
    }

    @GetMapping("/{id}")
    fun getAuthor(@PathVariable id: Long): ResponseEntity<Author> {
        val author = authorService.getAuthor(id)
        return if (author != null) ResponseEntity.ok(author) else ResponseEntity.notFound().build()
    }

    @PutMapping("/{id}")
    fun updateAuthor(@PathVariable id: Long, @RequestBody req: AuthorRequest): ResponseEntity<Author> {
        val author = authorService.updateAuthor(
            id = id,
            name = req.name,
            birthdate = java.time.LocalDate.parse(req.birthdate)
        )
        return ResponseEntity.ok(author)
    }

    @DeleteMapping("/{id}")
    fun deleteAuthor(@PathVariable id: Long): ResponseEntity<Void> {
        val deleted = authorService.deleteAuthor(id)
        return if (deleted) ResponseEntity.noContent().build() else ResponseEntity.notFound().build()
    }

    @GetMapping
    fun listAuthors(): ResponseEntity<List<Author>> = ResponseEntity.ok(authorService.listAuthors())

    // 著者の書籍一覧取得
    @GetMapping("/{id}/books")
    fun getBooksByAuthor(@PathVariable id: Long): ResponseEntity<List<BookSimpleResponse>> {
        val author = authorService.getAuthor(id)
        return if (author != null) {
            val books = author.books.map { b ->
                BookSimpleResponse(b.id, b.title, b.price, b.status)
            }
            ResponseEntity.ok(books)
        } else {
            ResponseEntity.notFound().build()
        }
    }
}
