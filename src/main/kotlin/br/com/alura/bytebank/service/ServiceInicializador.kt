package br.com.alura.bytebank.service

import br.com.alura.bytebank.model.Feature
import org.springframework.stereotype.Service

@Service
class ServiceInicializador(
        private val featureService: FeatureService
) {

    fun salvaFeaturesPadroes() {
        featureService.salva(Feature(
                1,
                disponivel = true
        ))
        featureService.salva(Feature(
                2,
                disponivel = true
        ))
    }

}