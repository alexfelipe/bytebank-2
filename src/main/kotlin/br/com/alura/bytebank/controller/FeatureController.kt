package br.com.alura.bytebank.controller

import br.com.alura.bytebank.dto.FeatureRequisicao
import br.com.alura.bytebank.dto.FeatureResposta
import br.com.alura.bytebank.service.FeatureService
import org.springframework.http.HttpEntity
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

private const val idInvalido = "id inválido"

@RestController
@RequestMapping("/features")
class FeatureController(private val service: FeatureService) {

    @GetMapping
    fun todas(): HttpEntity<List<FeatureResposta>> {
        return service.todas()
                .map { FeatureResposta(it) }
                .let { ResponseEntity.ok(it) }
    }

    @GetMapping("/disponiveis")
    fun disponiveis(): HttpEntity<List<FeatureResposta>> {
        return service.disponiveis()
                .map { FeatureResposta(it) }
                .let { ResponseEntity.ok(it) }
    }

    @PostMapping
    fun salva(@RequestBody requisicao: FeatureRequisicao): HttpEntity<Any> {
        requisicao.feature.let { featureRecebida ->
            if(service.valida(featureRecebida)){
                return service.salva(requisicao.feature)
                        .let { featureSalva ->
                            ResponseEntity.ok(FeatureResposta(featureSalva))
                        }
            }
            return ResponseEntity(idInvalido, HttpStatus.BAD_REQUEST)
        }

    }

}