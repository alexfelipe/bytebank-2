package br.com.alura.bytebank.controller

import br.com.alura.bytebank.dto.TransferenciaRequisicao
import br.com.alura.bytebank.dto.TransferenciaResposta
import br.com.alura.bytebank.model.ValidadorSenha
import br.com.alura.bytebank.service.TransferenciaService
import org.springframework.http.HttpEntity
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

private const val transacaoExistente = "Transação já existente"
private const val falhaAutenticacao = "falha na autenticação"

@RestController
@RequestMapping("/transferencias")
class TransferenciasController(
        private val service: TransferenciaService,
        private val validador: ValidadorSenha) {

    @GetMapping
    fun todas(): HttpEntity<List<TransferenciaResposta>> {
        return service.todas().map { TransferenciaResposta(it) }
                .let { resposta ->
                    ResponseEntity.ok(resposta)
                }
    }

    @PostMapping
    fun salva(@RequestBody requisicao: TransferenciaRequisicao,
              @RequestHeader("senha") senha: String): HttpEntity<Any> {
        if (validador.valida(senha)) {
            requisicao.transferencia.let { transferenciaRecebida ->
                if (service.existe(transferenciaRecebida.id)) {
                    return ResponseEntity(transacaoExistente, HttpStatus.CONFLICT)
                }
                return service.salva(transferenciaRecebida)
                        .let { transferenciaSalva ->
                            ResponseEntity.ok(transferenciaSalva)
                        }
            }
        }
        return ResponseEntity(falhaAutenticacao, HttpStatus.UNAUTHORIZED)
    }

}