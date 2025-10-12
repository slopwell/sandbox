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
class BookApiContractTest @Autowired constructor(val restTemplate: TestRestTemplate) {
    @Test
    @DisplayName("POST /books 書籍新規登録の契約テスト")
    fun testPostBooksContract() {
        val req = mapOf("title" to "契約テスト本", "price" to 1000, "authors" to listOf(1), "status" to "PUBLISHED")
        val response = restTemplate.postForEntity("/books", req, Map::class.java)
        assertThat(response.statusCode).isEqualTo(HttpStatus.CREATED)
        assertThat(response.body).isInstanceOf(Map::class.java)
        assertThat((response.body as Map<*, *>) ["id"]).isNotNull()
    }

    @Test
    @DisplayName("PUT /books 書籍更新の契約テスト")
    fun testPutBooksContract() {
        val req = mapOf("title" to "契約テスト本", "price" to 1000, "authors" to listOf(1), "status" to "PUBLISHED")
        val postRes = restTemplate.postForEntity("/books", req, Map::class.java)
        val id = (postRes.body as Map<*, *>) ["id"]
        val putReq = mapOf("title" to "契約テスト本更新", "price" to 1200, "authors" to listOf(1), "status" to "PUBLISHED")
        val putRes = restTemplate.exchange("/books/$id", HttpMethod.PUT, HttpEntity(putReq), Map::class.java)
        assertThat(putRes.statusCode).isEqualTo(HttpStatus.OK)
        assertThat((putRes.body as Map<*, *>) ["title"]).isEqualTo("契約テスト本更新")
    }
}
