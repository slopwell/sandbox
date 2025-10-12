package models

import java.time.LocalDate

data class Author(
	val id: Long? = null,
	val name: String,
	val birthdate: LocalDate,
	val books: List<Book> = emptyList()
)
