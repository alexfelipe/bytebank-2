package br.com.alura.bytebank.model

import javax.persistence.Embeddable

@Embeddable
class Contato(
        val nome: String,
        val numeroConta: Int
)