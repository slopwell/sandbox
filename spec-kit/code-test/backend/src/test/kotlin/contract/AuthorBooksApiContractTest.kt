package contract

import org.junit.jupiter.api.Test
import org.junit.jupiter.api.DisplayName
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.web.client.TestRestTemplate
import org.springframework.http.*
import org.assertj.core.api.Assertions.assertThat
import com.example.Application

@SpringBootTest(classes = [Application::class], webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class AuthorBooksApiContractTest @Autowired constructor(val restTemplate: TestRestTemplate) {
    @Test
    @DisplayName("GET /authors/{authorId}/books 著者の書籍一覧取得契約テスト")
    fun testGetAuthorBooksContract() {
        val authorReq = mapOf("name" to "契約テスト著者", "birthdate" to "1970-01-01")
        val authorRes = restTemplate.postForEntity("/authors", authorReq, Map::class.java)
        val authorId = (authorRes.body as Map<*, *>) ["id"]
        val bookReq = mapOf("title" to "契約テスト本", "price" to 1000, "authors" to listOf(authorId), "status" to "PUBLISHED")
        restTemplate.postForEntity("/books", bookReq, Map::class.java)
        val getRes = restTemplate.getForEntity("/authors/$authorId/books", List::class.java)
        assertThat(getRes.statusCode).isEqualTo(HttpStatus.OK)
        assertThat(getRes.body).isInstanceOf(List::class.java)
        assertThat((getRes.body as List<*>)).isNotEmpty()
    }
}
