package br.com.alura.bytebank

import br.com.alura.bytebank.model.Feature
import br.com.alura.bytebank.service.FeatureService
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.stereotype.Component
import javax.annotation.PostConstruct

@SpringBootApplication
class BytebankApplication

fun main(args: Array<String>) {
	runApplication<BytebankApplication>(*args)
}

private const val featureHistorico = "historico"

private const val featureTransferir = "transferir"

@Component
class SalvaFeatures(private val service: FeatureService) {

	@PostConstruct
	fun init(){
		service.salva(Feature(featureTransferir))
		service.salva(Feature(featureHistorico))
	}

}