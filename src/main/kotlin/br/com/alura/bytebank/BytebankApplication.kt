package br.com.alura.bytebank

import br.com.alura.bytebank.service.ServiceInicializador
import org.springframework.boot.ApplicationRunner
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean

@SpringBootApplication
class BytebankApplication(
        private val service: ServiceInicializador) {

    @Bean
    fun executa() = ApplicationRunner {
        service.salvaFeaturesPadroes()
    }

}

fun main(args: Array<String>) {
    runApplication<BytebankApplication>(*args)
}