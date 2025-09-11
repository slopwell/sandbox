package integration

import org.junit.jupiter.api.Test
import org.junit.jupiter.api.DisplayName
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.web.client.TestRestTemplate
import org.springframework.http.*
import org.assertj.core.api.Assertions.assertThat
import com.example.Application

@SpringBootTest(classes = [Application::class], webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class BookAuthorIntegrationTest @Autowired constructor(val restTemplate: TestRestTemplate) {
    @Test
    @DisplayName("書籍・著者登録・更新・取得の統合テスト")
    fun testBookAuthorIntegration() {
        // 著者登録
        val authorReq = mapOf("name" to "統合テスト著者", "birthdate" to "1990-01-01")
        val authorRes = restTemplate.postForEntity("/authors", authorReq, Map::class.java)
        val authorId = (authorRes.body as Map<*, *>) ["id"]
        // 書籍登録
        val bookReq = mapOf("title" to "統合テスト本", "price" to 2000, "authors" to listOf(authorId), "status" to "PUBLISHED")
        val bookRes = restTemplate.postForEntity("/books", bookReq, Map::class.java)
        val bookId = (bookRes.body as Map<*, *>) ["id"]
        // 書籍更新
        val putReq = mapOf("title" to "統合テスト本改", "price" to 2500, "authors" to listOf(authorId), "status" to "PUBLISHED")
        val putRes = restTemplate.exchange("/books/$bookId", HttpMethod.PUT, HttpEntity(putReq), Map::class.java)
        assertThat(putRes.statusCode).isEqualTo(HttpStatus.OK)
        // 著者の書籍一覧取得
        val getRes = restTemplate.getForEntity("/authors/$authorId/books", List::class.java)
        assertThat(getRes.statusCode).isEqualTo(HttpStatus.OK)
        assertThat((getRes.body as List<*>)).anyMatch { (it as Map<*, *>) ["id"] == bookId }
    }
}
