package models

import java.time.LocalDate

object Validation {
	fun validateBook(price: Int, authors: List<Any>, status: String, prevStatus: String? = null): Boolean {
		if (price < 0) return false
		if (authors.isEmpty()) return false
		if (prevStatus == "出版済み" && status == "未出版") return false
		return true
	}

	fun validateAuthor(birthdate: LocalDate): Boolean {
		return birthdate.isBefore(LocalDate.now())
	}
}
