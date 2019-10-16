package br.com.alura.bytebank.service

import br.com.alura.bytebank.model.Feature
import org.springframework.stereotype.Service

private const val featureHistorico = "historico"

private const val featureTransferir = "transferir"

@Service
class ServiceInicializador(
        private val featureService: FeatureService
) {

    fun salvaFeaturesPadroes() {
        featureService.salva(Feature(
                1,
                featureTransferir,
                disponivel = true
        ))
        featureService.salva(Feature(
                2,
                featureHistorico,
                disponivel = true
        ))
    }

}