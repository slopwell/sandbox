package models

data class Book(
	val id: Long? = null,
	val title: String,
	val price: Int,
	val status: String,
	val authors: List<Author>
)
