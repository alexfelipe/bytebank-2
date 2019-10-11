package br.com.alura.bytebank.model

import java.math.BigDecimal
import java.time.LocalDateTime
import java.util.*
import javax.persistence.Embedded
import javax.persistence.Entity
import javax.persistence.Id

@Entity
class Transferencia(
        @Id
        val id: String = UUID.randomUUID().toString(),
        val valor: BigDecimal,
        @Embedded
        val contato: Contato,
        val data: LocalDateTime = LocalDateTime.now()
)
