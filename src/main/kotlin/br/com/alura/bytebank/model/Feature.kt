package br.com.alura.bytebank.model

import java.util.*
import javax.persistence.Entity
import javax.persistence.Id

@Entity
class Feature(
        @Id
        val id: String = UUID.randomUUID().toString(),
        val nome: String,
        val disponivel: Boolean = true
)