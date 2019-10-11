package br.com.alura.bytebank.model

import javax.persistence.Entity
import javax.persistence.Id

@Entity
class Feature(
        @Id
        val nome: String,
        val disponivel: Boolean = true
)