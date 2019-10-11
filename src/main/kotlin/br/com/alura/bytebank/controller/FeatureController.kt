package br.com.alura.bytebank.controller

import br.com.alura.bytebank.dto.FeatureRequisicao
import br.com.alura.bytebank.dto.FeatureResposta
import br.com.alura.bytebank.service.FeatureService
import org.springframework.http.HttpEntity
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/features")
class FeatureController(private val service: FeatureService) {

    @GetMapping
    fun todas(): HttpEntity<List<FeatureResposta>> {
        return service.todas()
                .map { feature -> FeatureResposta(feature) }
                .let { resposta -> ResponseEntity.ok(resposta) }
    }

    @PostMapping
    fun salva(@RequestBody requisicao: FeatureRequisicao): HttpEntity<FeatureResposta> {
        return service.salva(requisicao.feature)
                .let { featureSalva ->
                    ResponseEntity.ok(FeatureResposta(featureSalva))
                }
    }

}