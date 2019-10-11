package br.com.alura.bytebank.controller

import br.com.alura.bytebank.dto.TransferenciaRequisicao
import br.com.alura.bytebank.dto.TransferenciaResposta
import br.com.alura.bytebank.model.Transferencia
import br.com.alura.bytebank.service.TransferenciaService
import org.springframework.http.HttpEntity
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/transferencias")
class TransferenciasController(
        private val service: TransferenciaService) {

    @GetMapping
    fun todas(): HttpEntity<List<TransferenciaResposta>> {
        return service.todas().map { TransferenciaResposta(it) }
                .let { resposta ->
                    ResponseEntity.ok(resposta)
                }
    }

    @PostMapping
    fun salva(@RequestBody requisicao: TransferenciaRequisicao): HttpEntity<TransferenciaResposta> {
        val transferenciaRecebida = requisicao.transferencia
        return service.salva(transferenciaRecebida)
                .let { transferenciaSalva ->
                    ResponseEntity.ok(TransferenciaResposta(transferenciaSalva))
                }
    }

}