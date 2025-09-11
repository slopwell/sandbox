package contract

import org.junit.jupiter.api.Test
import org.assertj.core.api.Assertions.assertThat

class SimpleTest {
    @Test
    fun sanity() {
        assertThat(1 + 1).isEqualTo(2)
    }
}
