plugins {
    id "org.jlleitschuh.gradle.ktlint" version "12.1.0"
}

ktlint {
    version = "1.2.1"
    android = false
    outputToConsole = true
}
