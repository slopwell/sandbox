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
class AuthorApiContractTest @Autowired constructor(val restTemplate: TestRestTemplate) {
    @Test
    @DisplayName("POST /authors 著者新規登録の契約テスト")
    fun testPostAuthorsContract() {
        val req = mapOf("name" to "契約テスト著者", "birthdate" to "1980-01-01")
        val response = restTemplate.postForEntity("/authors", req, Map::class.java)
        assertThat(response.statusCode).isEqualTo(HttpStatus.CREATED)
        assertThat(response.body).isInstanceOf(Map::class.java)
    assertThat((response.body as Map<*, *>) ["id"]).isNotNull()
    }

    @Test
    @DisplayName("PUT /authors 著者更新の契約テスト")
    fun testPutAuthorsContract() {
        val req = mapOf("name" to "契約テスト著者", "birthdate" to "1980-01-01")
        val postRes = restTemplate.postForEntity("/authors", req, Map::class.java)
        val id = (postRes.body as Map<*, *>) ["id"]
        val putReq = mapOf("name" to "契約テスト著者更新", "birthdate" to "1980-01-01")
        val putRes = restTemplate.exchange("/authors/$id", HttpMethod.PUT, HttpEntity(putReq), Map::class.java)
        assertThat(putRes.statusCode).isEqualTo(HttpStatus.OK)
        assertThat((putRes.body as Map<*, *>) ["name"]).isEqualTo("契約テスト著者更新")
    }
}
