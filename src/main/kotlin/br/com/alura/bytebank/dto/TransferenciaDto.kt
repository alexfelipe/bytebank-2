package br.com.alura.bytebank.dto

import br.com.alura.bytebank.model.Contato
import br.com.alura.bytebank.model.Transferencia
import com.fasterxml.jackson.annotation.JsonFormat
import java.math.BigDecimal
import java.time.LocalDateTime
import java.util.*

open class TransferenciaRequisicao(
        id: String?,
        contato: Contato,
        valor: BigDecimal) {

    val transferencia: Transferencia = Transferencia(
            id = id ?: UUID.randomUUID().toString(),
            contato = contato,
            valor = valor
    )

}

class TransferenciaResposta(
        transferencia: Transferencia,
        val id: String = transferencia.id,
        val valor: BigDecimal = transferencia.valor,
        val contato: Contato = transferencia.contato,
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
        val data: LocalDateTime = transferencia.data
)

