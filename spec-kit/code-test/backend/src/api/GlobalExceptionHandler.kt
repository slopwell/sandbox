package api

import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.ControllerAdvice
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.MethodArgumentNotValidException

@ControllerAdvice
class GlobalExceptionHandler {
    @ExceptionHandler(IllegalArgumentException::class)
    fun handleIllegalArgument(e: IllegalArgumentException): ResponseEntity<Map<String, String>> =
        ResponseEntity(mapOf("error" to (e.message ?: "不正なリクエストです")), HttpStatus.BAD_REQUEST)

    @ExceptionHandler(NoSuchElementException::class)
    fun handleNotFound(e: NoSuchElementException): ResponseEntity<Map<String, String>> =
        ResponseEntity(mapOf("error" to (e.message ?: "リソースが見つかりません")), HttpStatus.NOT_FOUND)

    @ExceptionHandler(MethodArgumentNotValidException::class)
    fun handleValidation(e: MethodArgumentNotValidException): ResponseEntity<Map<String, String>> =
        ResponseEntity(mapOf("error" to "入力値が不正です"), HttpStatus.BAD_REQUEST)

    @ExceptionHandler(Exception::class)
    fun handleOther(e: Exception): ResponseEntity<Map<String, String>> =
        ResponseEntity(mapOf("error" to (e.message ?: "サーバーエラー")), HttpStatus.INTERNAL_SERVER_ERROR)
}
