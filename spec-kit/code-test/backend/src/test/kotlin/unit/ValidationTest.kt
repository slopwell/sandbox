package unit

import models.Validation
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test
import java.time.LocalDate

class ValidationTest {
    @Test
    fun `価格が0未満は無効`() {
        assertFalse(Validation.validateBook(-1, listOf(1), "未出版"))
    }
    @Test
    fun `著者が空は無効`() {
        assertFalse(Validation.validateBook(1000, emptyList(), "未出版"))
    }
    @Test
    fun `出版済みから未出版は無効`() {
        assertFalse(Validation.validateBook(1000, listOf(1), "未出版", "出版済み"))
    }
    @Test
    fun `生年月日が未来は無効`() {
        assertFalse(Validation.validateAuthor(LocalDate.now().plusDays(1)))
    }
    @Test
    fun `正常値は有効`() {
        assertTrue(Validation.validateBook(1000, listOf(1), "出版済み"))
        assertTrue(Validation.validateAuthor(LocalDate.now().minusYears(20)))
    }
}
